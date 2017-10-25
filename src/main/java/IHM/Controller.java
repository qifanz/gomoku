package IHM;

import java.util.Observable;
import java.util.Observer;

/**
 * Created by flavi on 2017/10/21.
 */
public class Controller implements Observer {

    Plateau plateau;

    public Controller(Plateau plateau) {
        this.plateau=plateau;

    }

    public void update(Observable o, Object arg) {
        int x=Integer.parseInt(((Entry)o).getColone().getText());
        int y=Integer.parseInt(((Entry)o).getLigne().getText());
        System.out.println(x+" "+y);
        plateau.addPiece(x,y);
    }
}
