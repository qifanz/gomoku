package IHM;

import javax.swing.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import Exception.GomokuFinishedException;

public class BoardPanel extends JPanel implements MouseMotionListener,MouseListener{

    public JLabel[][] Cases;

    private ImageIcon Board;
    private ImageIcon Black;
    private ImageIcon White;
    private ImageIcon Black2;
    private ImageIcon White2;

    private boolean blackTurn = true;
    private JLabel OpaqueWhite;
    private JLabel OpaqueBlack;

    public PrologCaller prologCaller;
    public HashMap<Integer,Boolean> played;

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
        played = new HashMap<Integer, Boolean>();
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
        final JFileChooser fc = new JFileChooser();
        fc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        fc.setDialogTitle("Please open the prolog directory");
        int retVal = fc.showOpenDialog(this);
        if(retVal == JFileChooser.APPROVE_OPTION){
            String dir = fc.getSelectedFile().getAbsolutePath();
            String[] choices = {"game_java_mm1_b.pl","game_java_mm2_b.pl","game_java_random_b.pl"};
            String iaFile = (String) JOptionPane.showInputDialog(this,"Which IA to use ?",
                    "IA selection",JOptionPane.QUESTION_MESSAGE,null,choices,choices[0]);
            try {
                prologCaller = new PrologCaller(dir,iaFile);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        this.addMouseMotionListener(this);
        this.addMouseListener(this);
    }

    // public methods
    public void nextMove(){
        int move = 0;
        try {
            move = prologCaller.getNextMove(played);
        }catch (GomokuFinishedException e){
            JOptionPane.showMessageDialog(this,e.getMessage(),"Gomoku says...",JOptionPane.INFORMATION_MESSAGE);
            System.exit(0);
        }
        if(move >0) placePiece(move);
    }

    public void placePiece(int pos){
        int x,y;
        x = pos%15;
        y = pos/15;
        if(!blackTurn && Cases[x][y].getIcon()==null){
            Cases[x][y].setBounds(18 + 52 * x, 20 + 52 * y, 35, 35);
            Cases[x][y].setIcon(White);
            this.validate();
            //System.out.println((y+1)+" "+(x+1));
            played.put(15*y+x,blackTurn);
            blackTurn = !blackTurn;
        }
    }

    //mouse listener

    public void mouseMoved(MouseEvent e) {
        //System.out.println(e.getX()+";"+e.getY()+"case :"+getCaseX(e)+":"+getCaseY(e));
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
            repaint();
            this.revalidate();
            played.put(15*y+x,blackTurn);
            blackTurn = !blackTurn;
            nextMove();
        }else if (Cases[x][y].getIcon()==null){
            Cases[x][y].setIcon(White);
            blackTurn = !blackTurn;
        }
    }

    public void mousePressed(MouseEvent e) {

    }

    public void mouseReleased(MouseEvent e) {

    }

    public void mouseEntered(MouseEvent e) {

    }

    public void mouseExited(MouseEvent e) {

    }

    public void mouseDragged(MouseEvent e) {

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
