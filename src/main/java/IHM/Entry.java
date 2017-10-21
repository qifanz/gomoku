package IHM;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;

/**
 * Created by flavi on 2017/10/21.
 */
public class Entry extends Observable {
    private JFrame frame;
    private JTextField colone;
    private JTextField ligne;
    private JButton confirmButton;
    private JPanel entryPanel;

    public Entry() {
        frame=new JFrame("gomoku entering");
        frame.setContentPane(entryPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        frame.setBounds(0,0,400,200);

        confirmButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                setChanged();
                notifyObservers();
            }
        });
    }

    public JTextField getColone() {
        return colone;
    }

    public JTextField getLigne() {

        return ligne;
    }
}
