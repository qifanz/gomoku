import IHM.Controller;
import IHM.Entry;
import IHM.Plateau;

/**
 * Created by flavi on 2017/10/21.
 */
public class Main {
    public static void main(String args[]) {
        Plateau plateau = new Plateau();
        Controller controller=new Controller(plateau);
//        Entry entry=new Entry();
//        entry.addObserver(controller);
    }

}
