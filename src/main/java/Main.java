import IHM.Controller;
import IHM.Entry;
import IHM.Plateau;
import org.jpl7.Atom;
import org.jpl7.JPL;
import org.jpl7.Query;
import org.jpl7.Term;

import javax.swing.*;


/**
 * Created by flavi on 2017/10/21.
 */
public class Main {
    public static void main(String args[]) {
        Plateau plateau = new Plateau();
        Controller controller=new Controller(plateau);
        Entry entry=new Entry();

        entry.addObserver(controller);
        JPL.init();
        Term consult_arg[] = {
                new Atom( "C://gomoku.pl" )
        };
        Query consult_query =
                new Query(
                        "init",
                        consult_arg );

        consult_query.getSolution();


    }

}
