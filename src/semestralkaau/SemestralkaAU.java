package semestralkaau;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import semestralkaau.graph.Node;
import semestralkaau.parser.Reader;
import semestralkaau.tptpbuilder.TPTPConsistencyAxioms;
import semestralkaau.tptpbuilder.TPTPControlSystemBuilder;
import semestralkaau.tptpbuilder.TPTPCriticalStatesChecking;
import semestralkaau.tptpbuilder.TPTPStationPhysicsBuilder;
import semestralkaau.util.Util;

/**
 *
 * @author zikesjan
 */
public class SemestralkaAU {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Collection<Node> graph = null;
        List<Node> startNodes = new ArrayList<>();
        List<Node> goalNodes = new ArrayList<>();

        //reading the text input
        try {
            graph = Reader.readGraphFromDot();
        } catch (IOException ex) {
            Logger.getLogger(SemestralkaAU.class.getName()).log(Level.SEVERE, null, ex);
        }

        //extracting start and goal nodes
        for (Node n : graph) {
            if (n.predecessors.isEmpty()) {
                startNodes.add(n);
            }
            if (n.outputs == 0) {
                goalNodes.add(n);
            }
        }

        //generating the tptp string that describes physical behaviour of the railway station
        String station = TPTPStationPhysicsBuilder.railwayGraphToTPTP(graph);
        System.out.println(station);
        System.out.println("");
        Util.writeStringToFile(station, "station.p");
        System.out.println("------------------------------");
        System.out.println("");
        
        //generating the tptp string that describes the control system
        String control = TPTPControlSystemBuilder.stationToControlSystemString(graph, startNodes, goalNodes);
        System.out.println(control);
        Util.writeStringToFile(control, "control.p");
        
        //generating the tptp files dealing with the critical states
        TPTPCriticalStatesChecking.generatePossibleCriticalStateCheckingFiles(graph, startNodes, goalNodes);
        
        //generating consistency axioms
        TPTPConsistencyAxioms.generateConsistencyAxioms(startNodes);
    }

}
