package semestralkaau.graph.routes;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import semestralkaau.graph.Node;

/**
 * class that represents one route in the graph
 * @author zikesjan
 */
public class Route {

    private List<Node> nodes;
    public Node start;
    public Node goal;

    public Route() {
        nodes = new ArrayList<>();
    }

    /**
     * something like copy constructor in C++ :D
     * @param collection 
     */
    public Route(Collection<Node> collection) {
        nodes = new ArrayList<>();
        for (Node n : collection) {
            nodes.add(n);
            if (n.predecessors.isEmpty()) {
                this.start = n;
            }
            if (n.outputs == 0) {
                this.goal = n;
            }
        }
    }

    /**
     * searching for conflict in node, it's asymptotycaly slow, but graphs are very small
     * for this problem
     * @param n
     * @return 
     */
    public boolean isConflicting(Node n) {
        if (n.outputs != 0 || !n.predecessors.isEmpty()) {
            return nodes.contains(n);
        }
        return false;
    }

    /**
     * searching if there is conflict with whole route, again asymptoticaly not optimal, but
     * graphs are very small
     * @param r
     * @return 
     */
    public boolean isConflicting(Route r) {
        for (Node n : r.getNodes()) {
            if (!n.predecessors.isEmpty()) {
                if (nodes.contains(n)) {
                    return true;
                }
            }
        }
        return false;
    }

    public List<Node> getNodes() {
        return this.nodes;
    }

    public void addNode(Node node) {
        this.nodes.add(node);
    }
}
