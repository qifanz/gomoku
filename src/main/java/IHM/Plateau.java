package IHM;

import javax.swing.*;

/**
 * Created by flavi on 2017/10/21.
 */
public class Plateau {
    public JPanel PlateauPanel;
    private JFrame frame;
    private JLabel[][] pos;

    public Plateau (){
        frame=new JFrame("gomoku");
        frame.setContentPane(PlateauPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        frame.setBounds(0,0,820,840);
        pos=new JLabel[15][15];
        /**JLabel bg=new JLabel();
        ImageIcon image = new ImageIcon(this.getClass().getResource("/plateau.jpg").getFile());
        bg.setBounds(0,0,800,800);
        bg.setIcon(image);
        PlateauPanel.add(bg);
        PlateauPanel.validate();**/

        for (int i=0;i<15;i++) {
            for (int j=0;j<15;j++) {
                pos[i][j]=new JLabel();
                PlateauPanel.add(pos[i][j]);
            }
        }

    }
    public void addPiece(int x,int y) {


        ImageIcon image = new ImageIcon(this.getClass().getResource("/black.png").getFile());
        pos[x][y].setBounds(35+48*x,35+48*y,35,35);
        pos[x][y].setIcon(image);
        PlateauPanel.validate();
    }
    private void createUIComponents() {
        // TODO: place custom component creation code here

    }
}
