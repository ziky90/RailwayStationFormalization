package semestralkaau.tptpbuilder;

import java.util.Collection;
import java.util.List;
import semestralkaau.graph.GraphUtil;
import semestralkaau.graph.Node;
import semestralkaau.graph.routes.Route;

/**
 * class that is building the formalism of the railway stations controll system
 * in tptp
 *
 * @author zikesjan
 */
public class TPTPControlSystemBuilder {

    public static final String setPath = "\n\nfof(setPath, axiom, (![X,P]: (configuration(succ(X),P) <=> ((configuration(X,P) & ~free(X,P)) | toBeUsed(X,P))))).";
    
    public static String stationToControlSystemString(Collection<Node> grtaph, List<Node> startNodes, List<Node> goalNodes) {
        StringBuilder result = new StringBuilder("include('station.p').\n");
        //generate input order logic
        if (startNodes.size() > 1) {
            result.append("\n% logic that assure us changing of the input points in time");
            result.append("\n").append(generateOrderLogic(startNodes));
        }

        //geting all the routes in the graph
        List<Route> routes = GraphUtil.generateRouters(grtaph, goalNodes);

        //generate switch configuration axioms
        result.append("\n\n% formulation of all the possible routes by the switches configuration");
        result.append("\n").append(generateSwitchCofigurationAxioms(routes));

        //generate path is free axioms
        result.append("\n\n% formulation of what it means that the route is free");
        result.append("\n").append(generateFreePathsAxioms(routes));
        
        //generate axioms that are describing conflicting routes
        result.append("\n\n% formulation of which routes are conflicting");
        result.append("\n").append(generateConflictingRoutesAxioms(routes));
        
        //generate axioms that assure us that the paths are mutally exclusive        
        result.append("\n\n% axiom that assure us that all the routes are different");
        result.append("\n").append(generateMutalExclussivityAxioms(routes));

        //generate axioms that assure us that path is free and set
        result.append("\n\n% axioms that assure us that path is free and set before train can go");
        result.append("\n").append(generateAvailableRouteAxioms(routes));
        
        //generate axioms that determines where the trains would like to go
        result.append("\n\n% axioms that determines where the trains would like to go");
        result.append("\n").append(generateTrainWantsToGoAxioms(startNodes, goalNodes));
                
        //generate axioms that determines which path is supposed to be used in which situation
        result.append("\n\n% axioms that determines which path is supposed to be used in which situation");
        result.append("\n").append(generatePathToBeUsedAxioms(routes));
        
        //generate axiom how to set the path
        result.append("\n\n% axiom that set the path in the control system");
        result.append(setPath);
        
        //generate axioms describing how the inputs are opened
        result.append("\n\n% axiom that describes how the inputs are opened");
        result.append(generateInputGateAxioms(routes, startNodes));
        
        //TODO implement this
        return result.toString();
    }
    
    
    /**
     * method that generates axioms describing the input gates
     * @param routes
     * @param startNodes
     * @return 
     */
    private static StringBuilder generateInputGateAxioms(List<Route> routes, List<Node> startNodes){
        StringBuilder result = new StringBuilder();
        for(Node n : startNodes){
            result.append("\nfof(openGate").append(n.name).append(", axiom, (![X]: (open(succ(X),").append(n.name).append(") <=> (");
            for (int i = 0; i < routes.size(); i++) {
                if(routes.get(i).start.equals(n)){
                    result.append("toBeUsed(X, path").append(i).append(") | ");
                }
            }
            result.delete(result.length() - 3, result.length());
            result.append(")))).");
        }
        return result;
    }
    
    /**
     * method that generates axioms that decides which path is supposed to be used
     * @param routes
     * @return 
     */
    private static StringBuilder generatePathToBeUsedAxioms(List<Route> routes){
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < routes.size(); i++) {
            result.append("\nfof(pathToBeUsed").append(i).append(", axiom, (![X]: (toBeUsed(X, path").append(i).append(") <=> (available(X, path").append(i).append(") & clockOrder(X)=");
            result.append(routes.get(i).start.name).append(" & wantsToGo(X,").append(routes.get(i).start.name).append(",").append(routes.get(i).goal.name).append("))))).");
        }
        return result;
    }
    
    
    /**
     * method that generates axioms that says that the train wants to go from input i to output o
     * @param startNodes
     * @param goalNodes
     * @return 
     */
    private static StringBuilder generateTrainWantsToGoAxioms(List<Node> startNodes, List<Node> goalNodes){
        StringBuilder result = new StringBuilder();
        for(Node start : startNodes){
            for(Node goal : goalNodes){
                result.append("\nfof(wantsToGo").append(start.name).append(goal.name).append(", axiom, (![X]: ?[T]: (wantsToGo(X,").append(start.name).append(",").append(goal.name).append(") <=> (at(X,T,");
                result.append(start.name).append(") & goal(T)=").append(goal.name).append(")))).");
            }
        }
        return result;
    }
    
    /**
     * method that generates axioms that assure us that the given route is available
     * @param routes
     * @return 
     */
    private static StringBuilder generateAvailableRouteAxioms(List<Route> routes){
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < routes.size(); i++) {
            result.append("\nfof(availableRoute").append(i).append(", axiom, (![X]: (available(X, path").append(i).append(") <=> (nonconflicting(X, path").append(i).append(") & configuration(X, path");
            result.append(i).append("))))).");
        }
        return result;
    }

    /**
     * method that generates axioms that assures us that all the paths are different
     * @param routes
     * @return 
     */
    private static StringBuilder generateMutalExclussivityAxioms(List<Route> routes){
        StringBuilder result = new StringBuilder();
        result.append("\nfof(routesExclusivity, axiom, (");
        for (int i = 0; i < routes.size(); i++) {
            for (int j = i+1; j < routes.size(); j++) {
                result.append("(path").append(i).append(" != path").append(j).append(") & ");
            }
        }
        result.delete(result.length() - 3, result.length());
        result.append(")).");
        return result;
    }
    
    /**
     * method that generates axioms that are describing conflicting routes
     * @param routes
     * @return 
     */
    private static StringBuilder generateConflictingRoutesAxioms(List<Route> routes){
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < routes.size(); i++) {
            result.append("\nfof(nonconflicting").append(i).append(", axiom, (![X]: (nonconflicting(X, path").append(i).append(") <=> ((free(X, path").append(i).append(")) & ");
            for (int j = 0; j < routes.size(); j++) {
                if(i != j && routes.get(i).isConflicting(routes.get(j))){
                    result.append("(free(X, path").append(j).append(")) & ");
                }
            }
            result.delete(result.length() - 3, result.length());
            result.append(")))).");
        }
        return result;
    }
    
    
    /**
     * method that generates axioms that describes that the given route is free
     * @param routes
     * @return 
     */
    private static StringBuilder generateFreePathsAxioms(List<Route> routes) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < routes.size(); i++) {
            result.append("\nfof(freeRoute").append(i).append(", axiom, (![X, T]: (free(X, path").append(i).append(") <=> (");
            List<Node> nodes = routes.get(i).getNodes();
            //HashSet<Node> used = new HashSet<>();
            for (int j = 1; j < nodes.size() - 1; j++) {
                result.append("(~at(X, T, ").append(nodes.get(j).name).append(")) & ");
                //used.add(nodes.get(j));
            }
            /*Route actual = routes.get(i);
            for (Route r : routes) {
                if (actual.isConflicting(r)) {
                    for (int j = 0; j < nodes.size() - 1; j++) {
                        if (!used.contains(nodes.get(j))) {
                            result.append("(~at(X, T, ").append(nodes.get(j).name).append(")) & ");
                            used.add(nodes.get(j));
                        }
                    }
                }
            }*/
            result.delete(result.length() - 3, result.length());
            result.append(")))).");
        }
        return result;
    }

    /**
     * method that generates switch configuring axioms
     *
     * @param routes
     * @return
     */
    private static StringBuilder generateSwitchCofigurationAxioms(List<Route> routes) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < routes.size(); i++) {
            result.append("\nfof(switchesConfiguration").append(i).append(", axiom, (![X]: (configuration(X, path").append(i).append(") <=> (");
            List<Node> nodes = routes.get(i).getNodes();
            for (int j = 0; j < nodes.size() - 2; j++) {
                result.append("(switch(X, ").append(nodes.get(j + 1).name).append(") = ").append(nodes.get(j).name).append(") & ");
            }
            result.delete(result.length() - 3, result.length());
            result.append(")))).");
        }
        return result;
    }

    /**
     * method that generates "clock" system that assures us that there are
     * traveling trains from different nodes
     *
     * @param startNodes
     * @return
     */
    private static StringBuilder generateOrderLogic(List<Node> startNodes) {
        StringBuilder result = new StringBuilder();

        //building rules shoving that there is one after another input scheduled based on the clock
        for (int i = 0; i < startNodes.size(); i++) {
            if (i == 0) {
                //TODO append comment line
                result.append("\nfof(clockOrder").append(startNodes.get(i).name).append(", axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = ").append(startNodes.get(i).name).append(") <=> (clockOrder(succ(X)) = ");
                result.append(startNodes.get(startNodes.size() - 1).name).append("))))).");
            } else {
                //TODO append comment line
                result.append("\nfof(clockOrder").append(startNodes.get(i).name).append(", axiom, (![X]: ((succ(X) != X) => ((clockOrder(X) = ").append(startNodes.get(i).name).append(") <=> (clockOrder(succ(X)) = ");
                result.append(startNodes.get(i - 1).name).append("))))).");
            }
        }

        //building the rule that shows that there must be exacly on possibility at time
        result.append("\nfof(clockPossibilities, axiom, (![X]: (");
        for (Node n : startNodes) {
            result.append("(clockOrder(X) = ").append(n.name).append(") | ");
        }
        result.delete(result.length() - 3, result.length());
        result.append("))).");
        return result;
    }
}
