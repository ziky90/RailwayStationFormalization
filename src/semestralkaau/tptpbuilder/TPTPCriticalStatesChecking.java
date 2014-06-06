
package semestralkaau.tptpbuilder;

import java.util.Collection;
import java.util.List;
import semestralkaau.graph.Node;
import semestralkaau.util.Util;

/**
 *
 * @author zikesjan
 */
public class TPTPCriticalStatesChecking {

    public static void generatePossibleCriticalStateCheckingFiles(Collection<Node> graph, List<Node> startNodes, List<Node> goalNodes){
        for(Node n : graph){
            createNo2TrainsAtOneNodeCheck(n);
            if(!n.predecessors.isEmpty() && n.outputs != 0){
                createNoTrainOnChangingSwitch(n);
            }
        }
        for(Node n : startNodes){
            createGateWillOpen(n);
        }
    }
    
    
    private static void createGateWillOpen(Node n){
        StringBuilder result = new StringBuilder("include('control.p').\ninclude('consistencyAxioms.p').\n");
        result.append("\nfof(goIfOpen").append(n.name).append(", axiom, ![X,T]: ((at(X,T,").append(n.name).append(") & go(X,T)) => open(X,").append(n.name).append("))).\n");
        result.append("\nfof(willOpen").append(n.name).append(", conjecture, (?[X]: (open(X,").append(n.name).append(")))).");
        Util.writeStringToFile(result.toString(), n.name+"willOpen.p");
    }
    
    private static void createNoTrainOnChangingSwitch(Node n){
        StringBuilder result = new StringBuilder("include('control.p').\n");
        result.append("\nfof(changeOnlyWithoutTrain, conjecture, (![X,T]: ((at(X,T,").append(n.name).append(") & at(succ(X),T,").append(n.name).append(")) => (switch(X,").append(n.name).append(") = switch(X,");
        result.append(n.name).append("))))).");
        Util.writeStringToFile(result.toString(), n.name+"noTrainOnChangingSwitch.p");
    }
    
    private static void createNo2TrainsAtOneNodeCheck(Node n){
        StringBuilder result = new StringBuilder("include('control.p').\n");
        result.append("\nfof(no2Trains, conjecture, (![T1, T2, X]: ((at(X,T1,").append(n.name).append(") & (T1 != T2)) => (~at(X, T2,").append(n.name).append("))))).");
        Util.writeStringToFile(result.toString(), n.name+"no2trains.p");
    }
    
}
