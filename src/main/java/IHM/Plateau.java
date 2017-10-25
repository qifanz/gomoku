package IHM;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;

/**
 * Created by flavi on 2017/10/21.
 */
public class Plateau {

    public BoardPanel PlateauPanel;
    private JFrame frame;
    private JLabel[][] pos;

    public Plateau (){
        frame=new JFrame("gomoku");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        pos=new JLabel[15][15];
        PlateauPanel = new BoardPanel(pos);
        PlateauPanel.validate();
        frame.setContentPane(PlateauPanel);
        frame.setVisible(true);
        frame.setBounds(0,0,820,840);
    }

    public void addPiece(int x,int y) {

        ImageIcon image = new ImageIcon(this.getClass().getResource("/black.png").getFile());
        pos[x][y].setBounds(35+48*x,35+48*y,35,35);
        pos[x][y].setIcon(image);
        PlateauPanel.validate();
    }
}
