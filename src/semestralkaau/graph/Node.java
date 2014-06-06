package semestralkaau.graph;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * class that represents one node in the graph
 * @author zikesjan
 */
public class Node {
    
    public String name;
    public List<Node> predecessors;
    //number of descendants
    public int outputs;
    
    public Node(String name){
        this.name = name;
        this.outputs = 0;
        this.predecessors = new ArrayList<>();
    }

    
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 97 * hash + Objects.hashCode(this.name);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Node other = (Node) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        return true;
    }
}
