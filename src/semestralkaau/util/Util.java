
package semestralkaau.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 *
 * @author zikesjan
 */
public class Util {

    public static void writeStringToFile(String string, String filename) {
        File file = new File(filename);
        
        try (FileOutputStream fop = new FileOutputStream(file)) {
            // if file doesn't exists, then create it
            /*if (!file.exists()) {
                file.createNewFile();
            }else{
                file.delete();
                file.createNewFile();
            }*/

            // get the content in bytes
            byte[] contentInBytes = string.getBytes();

            fop.write(contentInBytes);
            fop.flush();
            fop.close();

            System.out.println("\nsaved to file:>> "+filename);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
}
