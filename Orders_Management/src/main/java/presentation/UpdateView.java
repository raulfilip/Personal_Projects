package presentation;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;



public class UpdateView extends JFrame{

    private static JFrame frame;
    private JTextField field1;
    private JTextField field2;
    private JTextField field3;
    private JTextField field4;
    private JButton btnUp;
    private JButton btnBack;

    public UpdateView(String name, String txt1, String txt2, String txt3, String txt4){

        SecondView.getFrame().setVisible(false);

        frame = new JFrame();

        frame.setBounds(100, 100, 628, 381);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        JLabel lblNewLabel = new JLabel(name);
        lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 30));
        lblNewLabel.setBounds(162, 33, 289, 40);
        frame.getContentPane().add(lblNewLabel);

        btnUp = new JButton("Update");

        btnUp.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnUp.setBounds(423, 176, 130, 55);
        frame.getContentPane().add(btnUp);

        field1 = new JTextField();
        field1.setBounds(208, 110, 123, 40);
        frame.getContentPane().add(field1);
        field1.setColumns(10);

        field2 = new JTextField();
        field2.setColumns(10);
        field2.setBounds(208, 169, 123, 40);
        frame.getContentPane().add(field2);

        field3 = new JTextField();
        field3.setColumns(10);
        field3.setBounds(208, 225, 123, 40);
        frame.getContentPane().add(field3);

        field4 = new JTextField();
        field4.setColumns(10);
        field4.setBounds(208, 279, 123, 40);
        frame.getContentPane().add(field4);

        JLabel lblNewLabel_1 = new JLabel(txt1);
        lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1.setBounds(41, 123, 123, 27);
        frame.getContentPane().add(lblNewLabel_1);

        JLabel lblNewLabel_1_1 = new JLabel(txt2);
        lblNewLabel_1_1.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_1.setBounds(41, 171, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_1);

        JLabel lblNewLabel_1_2 = new JLabel(txt3);
        lblNewLabel_1_2.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_2.setBounds(41, 227, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_2);

        JLabel lblNewLabel_1_3 = new JLabel(txt4);
        lblNewLabel_1_3.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_3.setBounds(41, 281, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_3);

        btnBack = new JButton("Back");
        btnBack.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnBack.setBounds(423, 253, 130, 55);
        frame.getContentPane().add(btnBack);

        frame.setVisible(true);
    }

    public JTextField getField1() {
        return field1;
    }

    public JTextField getField2() {
        return field2;
    }

    public JTextField getField3() {
        return field3;
    }

    public JTextField getField4() {
        return field4;
    }

    public static JFrame getFrame() {
        return frame;
    }

    public void addBack2Listener(ActionListener mal){btnBack.addActionListener(mal);}
    public void addUpdate2Listener(ActionListener mal){btnUp.addActionListener(mal);}


}
