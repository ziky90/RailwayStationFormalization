
package semestralkaau.tptpbuilder;

import java.util.Collection;
import semestralkaau.graph.Node;
import semestralkaau.util.Util;

/**
 *
 * @author zikesjan
 */
public class TPTPConsistencyAxioms {

    
    public static void generateConsistencyAxioms(Collection<Node> inputs){
        StringBuilder result = new StringBuilder("\nfof(goIfItsPossible, axiom, (![X,T]: ((go(X,T))))).\n");
        for(Node n : inputs){
            result.append("\nfof(alwaysAppears").append(n.name).append(", axiom, (![X]:?[Y]: (appear(X,Y,").append(n.name).append(")))).");
        }
        Util.writeStringToFile(result.toString(), "consistencyAxioms.p");
    }
    
}
