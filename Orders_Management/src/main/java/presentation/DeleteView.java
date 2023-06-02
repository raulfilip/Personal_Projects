package presentation;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;



public class DeleteView extends JFrame {
    private static JFrame frame;
    private JTextField textId;
    private JButton btnDelete;
    private JButton btnBack;

    public DeleteView(String name, String txt){
        SecondView.getFrame().setVisible(false);

        frame = new JFrame();

        frame.setBounds(100, 100, 628, 381);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        JLabel lblNewLabel = new JLabel(name);
        lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 30));
        lblNewLabel.setBounds(162, 32, 260, 40);
        frame.getContentPane().add(lblNewLabel);

        btnDelete = new JButton(txt);

        btnDelete.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnDelete.setBounds(408, 149, 130, 55);
        frame.getContentPane().add(btnDelete);

        textId = new JTextField();
        textId.setBounds(131, 160, 123, 40);
        frame.getContentPane().add(textId);
        textId.setColumns(10);

        JLabel lblNewLabel_1 = new JLabel("id:");
        lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 30));
        lblNewLabel_1.setBounds(42, 160, 123, 27);
        frame.getContentPane().add(lblNewLabel_1);

        btnBack = new JButton("Back");
        btnBack.setFont(new Font("Tahoma", Font.PLAIN, 20));

        btnBack.setBounds(408, 255, 130, 55);
        frame.getContentPane().add(btnBack);

        frame.setVisible(true);

    }

    public JTextField getTextId() {
        return textId;
    }

    public static JFrame getFrame() {
        return frame;
    }

    public void addBack2Listener(ActionListener mal){btnBack.addActionListener(mal);}
    public void addDelete2Listener(ActionListener mal){btnDelete.addActionListener(mal);}

}
