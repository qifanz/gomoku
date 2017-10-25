package IHM;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

public class BoardPanel extends JPanel implements MouseMotionListener,MouseListener{

    public JLabel[][] Cases;

    private ImageIcon Board;
    private ImageIcon Black;
    private ImageIcon White;
    private ImageIcon Black2;
    private ImageIcon White2;

    private boolean blackTurn;
    private JLabel OpaqueWhite;
    private JLabel OpaqueBlack;

    public BoardPanel(JLabel[][] c)
    {
        Cases = c;
        this.setLayout(null);
        JLabel bg=new JLabel();
        Board = new ImageIcon(this.getClass().getResource("/plateau.jpg").getFile());
        Black = new ImageIcon(this.getClass().getResource("/black.png").getFile());
        White = new ImageIcon(this.getClass().getResource("/white.png").getFile());
        Black2 = new ImageIcon(this.getClass().getResource("/black2.png").getFile());
        White2 = new ImageIcon(this.getClass().getResource("/white2.png").getFile());
        OpaqueBlack = new JLabel();
        OpaqueWhite = new JLabel();
        bg.setBounds(0,0,800,800);
        bg.setIcon(Board);
        for (int i=0;i<15;i++) {
            for (int j=0;j<15;j++) {
                Cases[i][j]=new JLabel();
                this.add(Cases[i][j]);
            }
        }
        this.add(OpaqueWhite);
        this.add(OpaqueBlack);
        this.add(bg);
        this.addMouseMotionListener(this);
        this.addMouseListener(this);
    }


    //mouse listener

    public void mouseDragged(MouseEvent e) {

    }

    public void mouseMoved(MouseEvent e) {
        System.out.println(e.getX()+";"+e.getY()+"case :"+getCaseX(e)+":"+getCaseY(e));
        int x = getCaseX(e);
        int y = getCaseY(e);
        if(blackTurn){
            OpaqueBlack.setBounds(18 + 52 * x, 20 + 52 * y, 35, 35);
            OpaqueBlack.setIcon(Black2);
        }else{
            OpaqueWhite.setBounds(18 + 52 * x, 20 + 52 * y, 35, 35);
            OpaqueWhite.setIcon(White2);
        }
        this.validate();
    }

    public void mouseClicked(MouseEvent e) {
        int x = getCaseX(e);
        int y = getCaseY(e);
        Cases[x][y].setBounds(18 + 52 * x, 20 + 52 * y, 35, 35);
        if (blackTurn && Cases[x][y].getIcon()==null) {
            Cases[x][y].setIcon(Black);
            blackTurn = !blackTurn;
        }else if (Cases[x][y].getIcon()==null){
            Cases[x][y].setIcon(White);
            blackTurn = !blackTurn;
        }
        this.validate();
    }

    public void mousePressed(MouseEvent e) {

    }

    public void mouseReleased(MouseEvent e) {

    }

    public void mouseEntered(MouseEvent e) {

    }

    public void mouseExited(MouseEvent e) {

    }

    private int getCaseX(MouseEvent e){
        int a = (int) Math.round((e.getX()-35.0)/52.0);
        return a < 0 ? 0 : a;
    }
    private int getCaseY(MouseEvent e){
        int a = (int) Math.round((e.getY()-38.0)/52.0);
        return a < 0 ? 0 : a;
    }
}
