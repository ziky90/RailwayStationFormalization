package semestralkaau.tptpbuilder;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import semestralkaau.graph.Node;

/**
 *
 * @author zikesjan
 */
public class TPTPStationPhysicsBuilder {

    //private static final String time = "fof(antisymmetry, axiom, (![X,Y]: ((less(X,Y) & less(Y,X)) => (X = Y)))).\nfof(transitivity, axiom, (![X,Y,Z]: ((less(X,Y) & less(Y, Z)) => less(X, Z)))).\nfof(totality, axiom, (![X,Y]: (less(X,Y) | less(Y,X)))).\nfof(succ, axiom, (![X]:((less(X,succ(X))) & (![Y]: (less(Y,X) | less(succ(X), Y)))))).\nfof(pred, axiom, (![X]: (((pred(succ(X)) = X) & (succ(pred(X)) = X))))).\n";
    private static final String includeOrder = "include('order.p').\n";
    private static final String includeConsistencyAxioms = "include('consistencyAxioms.p').\n";
    private static final String go = "\nfof(go, axiom, (![X,T]: (train(T) => (?[X2]:(less(X,X2) & go(X2,T)))))).";
    private static final String goComment = "\n% formalism of the go rule\n";
    private static final String trainIsAtOnePosition = "\n\nfof(positionInOneNodeAtTime, axiom, (![X,T,N1,N2]: ((at(X,T,N1) & at(X,T,N2)) => (N1=N2)))).";
    private static StringBuilder tptp = new StringBuilder(includeOrder).append(includeConsistencyAxioms).append(goComment).append(go).append("\n");
    private static HashSet<Node> used = new HashSet<>();

    public static String railwayGraphToTPTP(Collection<Node> rails) {
        //positions in non output nodes
        HashSet<Node> todo = new HashSet<>();
        List<Node> outputs = new ArrayList<>();
        List<Node> inputs = new ArrayList<>();
        tptp.append("\n% formalism for each of the nodes\n");
        for (Node node : rails) {
            if (node.outputs == 0) {
                todo.add(node);
                outputs.add(node);
            }
            if(node.predecessors.isEmpty()){
                inputs.add(node);
            }
        }
        while (!todo.isEmpty()) {
            todo = processAnotherLevel(todo);
        }
        
        //rule that makes all the nodes to be different
        List<Node> nodes = new ArrayList<>();
        nodes.addAll(rails);
        tptp.append("\n\n% all the nodes are different");
        tptp.append(nodesAreDifferent(nodes));
        
        //rule that train will disappear in the output
        tptp.append("\n\n% trains are disapearing in the outputs");
        tptp.append(trainsDisappearInOutputs(outputs));
        
        //rule that train can be only at one position
        tptp.append("\n\n% train can be only at ane node at time");
        tptp.append(trainIsAtOnePosition);
        
        //rule that there can be only one train at the input at time
        tptp.append("\n\n% there can be only one train at the input at time");
        tptp.append(onlyOneTrainAtInput(inputs));
        
        //rule that trains are entering the station
        tptp.append("\n\n% axioms describing the way how the trains are entering the station");
        tptp.append(trainsAreEnteringTheStation(inputs));
                
        //generate axiom that the train gas goal in one of outputs
        tptp.append("\n\n% axiom that the train has goal in one of outputs");
        tptp.append("\n").append(generateTrainGoals(outputs));
        
        return tptp.toString();
    }

    
    
    /**
     * method that generates axiom that says that every train has it's goal
     * @param goalNodes
     * @return 
     */
    private static StringBuilder generateTrainGoals(List<Node> goalNodes){
        StringBuilder result = new StringBuilder();
        result.append("\nfof(trainGoals, axiom, (![T]: (");
        for(Node n : goalNodes){
            result.append("(goal(T)=").append(n.name).append(") | ");
        }
        result.delete(result.length() - 3, result.length());
        result.append("))).");
        return result;
    }
    
    
    /*private static StringBuilder trainCanGoIffItsOpen(List<Node> inputs){
        StringBuilder result = new StringBuilder();
        result.append("\n");
        for(Node n : inputs){
            result.append("\nfof(canGo").append(n.name).append(", axiom, (![X,T]: ((go(X,T) & at(X,T,").append(n.name).append(")) => open(X,").append(n.name).append(")))).");
        }
        return result;
    }*/
    
    
    private static StringBuilder trainsAreEnteringTheStation(List<Node> inputs){
        StringBuilder result = new StringBuilder();
        result.append("\n");
        for(Node n : inputs){
            result.append("\nfof(appear").append(n.name).append(", axiom, (![X,T]: (at(succ(X),T,").append(n.name).append(") <=> (appear(X,T,").append(n.name).append(") | (at(X,T,").append(n.name);
            result.append(") & (~go(X,T) | ~open(X,").append(n.name).append("))))))).");
        }
        return result;
    }
    
    private static StringBuilder onlyOneTrainAtInput(List<Node> inputs){
        StringBuilder result = new StringBuilder();
        result.append("\n");
        for(Node n : inputs){
            result.append("\nfof(onlyOneTrain").append(n.name).append(", axiom, (![X,T1,T2]: ((at(X,T1,").append(n.name).append(") & (T1!=T2)) => (~at(X,T2,").append(n.name).append("))))).");
        }
        return result;
    }
    
    
    private static StringBuilder trainsDisappearInOutputs(List<Node> outputs){
        StringBuilder result = new StringBuilder();
        result.append("\n");
        for(Node n : outputs){
            result.append("\nfof(disappear").append(n.name).append(", axiom, (![X,T]: (at(X,T,").append(n.name).append(") => (~at(succ(X),T,").append(n.name).append("))))).");
        }
        return result;
    }
    
    
    private static StringBuilder nodesAreDifferent(List<Node> nodes){
        StringBuilder result = new StringBuilder();
        result.append("\n\nfof(nodesExclusivity, axiom, (");
        for (int i = 0; i < nodes.size(); i++) {
            for (int j = i+1; j < nodes.size(); j++) {
                result.append("(").append(nodes.get(i).name).append(" != ").append(nodes.get(j).name).append(") & ");
            }
        }
        result.delete(result.length() - 3, result.length());
        result.append(")).");
        return result;
    }
    
    
    private static HashSet<Node> processAnotherLevel(HashSet<Node> todo) {
        HashSet<Node> result = new HashSet<>();
        for (Node node : todo) {
            if (!used.contains(node)) {
                tptp.append("\nfof(").append(node.name).append("ax1, axiom, (![X,T]: ((train(T) & go(X,T) & (");
                for (Node from : node.predecessors) {
                    if (!from.predecessors.isEmpty()) {
                        tptp.append(" (switch(X,").append(from.name).append(") = ").append(node.name);
                        tptp.append(" & at(X,T,").append(from.name).append(")) |");
                        result.add(from);
                    } else {
                        tptp.append(" (open(X,").append(from.name).append(") & at(X,T,").append(from.name).append(")) |");
                    }
                }
                tptp.deleteCharAt(tptp.length() - 1);
                tptp.append(")) <=> at(succ(X),T,").append(node.name).append(")))).");
                used.add(node);
            }
        }
        return result;
    }
}
