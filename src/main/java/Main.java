import IHM.Controller;
import IHM.Entry;
import IHM.Plateau;
import org.jpl7.Atom;
import org.jpl7.JPL;
import org.jpl7.Query;
import org.jpl7.Term;

import javax.swing.*;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.Hashtable;
import java.util.Map;


/**
 * Created by flavi on 2017/10/21.
 */
public class Main {
    public static void main(String args[]) {
        Plateau plateau = new Plateau();
        Controller controller=new Controller(plateau);
        Entry entry=new Entry();
        entry.addObserver(controller);

        // redirection out stream
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ByteArrayOutputStream baos2 = new ByteArrayOutputStream();

        PrintStream ps = new PrintStream(baos);
        PrintStream ps2 = new PrintStream(baos2);
        // IMPORTANT: Save the old System.out!
        PrintStream old = System.out;
        PrintStream old2 = System.err;
        // Tell Java to use your special stream
//        System.setOut(ps);
//        System.setErr(ps2);

        JPL.init();
        Term consult_arg[] = {
                new Atom( "E://gomoku.pl" )
        };
        Query consult_query =
                new Query(
                        "consult",consult_arg);
        consult_query.open();
        consult_query.getSolution();
        consult_query.close();

        Query initGameQuery = new Query("init.");
        initGameQuery.open();
        //Map resp = initGameQuery.getSolution();
        initGameQuery.close();
    }

}
