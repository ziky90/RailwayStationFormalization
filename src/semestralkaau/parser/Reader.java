package semestralkaau.parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Collection;
import java.util.HashMap;
import java.util.StringTokenizer;
import semestralkaau.graph.Node;

/**
 *
 * @author zikesjan
 */
public class Reader {
    
    
    /**
     * reading the data from the standard input and building the graph
     * @return
     * @throws IOException 
     */
    public static Collection<Node> readGraphFromDot() throws IOException {
        HashMap<String, Node> graph = new HashMap<>();
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        String s = st.nextToken();
        while(!s.equals("{")){
            if(!st.hasMoreTokens()){
                st = new StringTokenizer(br.readLine());
            }
            s = st.nextToken();
        }
        
        //taking care of the whole block
        while(true){                                                  
            if(!st.hasMoreTokens()){
                st = new StringTokenizer(br.readLine());
            }
            s = st.nextToken();
            if(s.equals("}")) {
                break;
            }
            Node from;
            if(graph.containsKey(s)){
                from = graph.get(s);
            }else{
                from = new Node(s);
                graph.put(s, from);
            }
            st.nextToken();
            s = st.nextToken();
            s = s.substring(0, s.length()-1);
            Node to;
            if(graph.containsKey(s)){
                to = graph.get(s);
            }else{
                to = new Node(s);
                graph.put(s, to);
            }
            to.predecessors.add(from);
            from.outputs++;
        }
        return graph.values();
    }
}
