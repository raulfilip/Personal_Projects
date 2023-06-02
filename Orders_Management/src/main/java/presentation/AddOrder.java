package presentation;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class AddOrder extends JFrame {
    private static JFrame frame;
    private JTextField field1;
    private JTextField field4;
    private JButton btnAdd;
    private JButton btnBack;
    private JComboBox comboBoxC;
    private JComboBox comboBoxP;

    public AddOrder(String name, String[] listC, String[] listP){
        SecondView.getFrame().setVisible(false);

        frame = new JFrame();
        frame.setBounds(100, 100, 628, 381);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        JLabel lblNewLabel = new JLabel(name);
        lblNewLabel.setFont(new Font( "Tahoma",Font.PLAIN, 30));
        lblNewLabel.setBounds(162, 33, 260, 40);
        frame.getContentPane().add(lblNewLabel);

        btnAdd = new JButton("Insert");
        btnAdd.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnAdd.setBounds(423, 176, 130, 55);
        frame.getContentPane().add(btnAdd);

        field1 = new JTextField();
        field1.setBounds(208, 110, 123, 40);
        frame.getContentPane().add(field1);
        field1.setColumns(10);

        field4 = new JTextField();
        field4.setColumns(10);
        field4.setBounds(208, 279, 123, 40);
        frame.getContentPane().add(field4);

        JLabel lblNewLabel_1 = new JLabel("ID");
        lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1.setBounds(41, 123, 123, 27);
        frame.getContentPane().add(lblNewLabel_1);

        JLabel lblNewLabel_1_1 = new JLabel("Client id");
        lblNewLabel_1_1.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_1.setBounds(41, 171, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_1);

        JLabel lblNewLabel_1_2 = new JLabel("Product id");
        lblNewLabel_1_2.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_2.setBounds(41, 227, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_2);

        JLabel lblNewLabel_1_3 = new JLabel("quantity");
        lblNewLabel_1_3.setFont(new Font("Tahoma", Font.PLAIN, 22));
        lblNewLabel_1_3.setBounds(41, 281, 123, 27);
        frame.getContentPane().add(lblNewLabel_1_3);

        btnBack = new JButton("Back");
        btnBack.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnBack.setBounds(423, 253, 130, 55);
        frame.getContentPane().add(btnBack);

        comboBoxC = new JComboBox();
        comboBoxC.setModel(new DefaultComboBoxModel(listC));
        comboBoxC.setSelectedIndex(0);
        comboBoxC.setBounds(208, 161, 123, 40);
        frame.getContentPane().add(comboBoxC);

        comboBoxP = new JComboBox();
        comboBoxP.setModel(new DefaultComboBoxModel(listP));
        comboBoxP.setSelectedIndex(0);
        comboBoxP.setBounds(208, 225, 123, 40);
        frame.getContentPane().add(comboBoxP);

        frame.setVisible(true);
    }


    public JComboBox getComboBoxC() {
        return comboBoxC;
    }

    public JComboBox getComboBoxP() {
        return comboBoxP;
    }

    public JTextField getField1() {
        return field1;
    }

    public JTextField getField4() {
        return field4;
    }

    public static JFrame getFrame() {
        return frame;
    }

    public void addInsert3Listener(ActionListener mal){btnAdd.addActionListener(mal);}
    public void addBack2Listener(ActionListener mal){btnBack.addActionListener(mal);}

}
