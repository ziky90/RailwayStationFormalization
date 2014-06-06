
package semestralkaau.graph;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import semestralkaau.graph.routes.Route;

/**
 * class that deals with solving of the graph problems
 * @author zikesjan
 */
public class GraphUtil {
    
    private static List<Route> routes = new ArrayList<>();
    
    /**
     * method to generate all the routes from origins to destinations in the railway station graph
     * @param graph
     * @param endNodes
     * @return 
     */
    public static List<Route> generateRouters(Collection<Node> graph, List<Node> endNodes){
       for(Node n : endNodes){
           dfs(n, new Route());
       }
       return routes;
    }
    
    /**
     * implementation of the standard dfs algorithm that prints all the paths from one source
     * @param actual
     * @param route 
     */
    private static void dfs(Node actual, Route route){
        route.addNode(actual);
        if(actual.predecessors.isEmpty()){
            routes.add(new Route(route.getNodes()));
        }
        for(Node n : actual.predecessors){
            dfs(n, route);
            route.getNodes().remove(route.getNodes().size()-1);
        }
    }
}
