package presentation;

import model.Client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.util.ArrayList;



public class ViewClients extends JFrame {
    private static JFrame frame;
    private JTable table;
    private JButton btnBack;

    public ViewClients(ArrayList<Client> list){
        SecondView.getFrame().setVisible(false);

        frame = new JFrame();

        frame.setBounds(100, 100, 816, 655);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        JLabel lblNewLabel = new JLabel("CLIENTS TABLE");
        lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 40));
        lblNewLabel.setBounds(263, 34, 367, 40);
        frame.getContentPane().add(lblNewLabel);

        String[] head = {"ID", "First Name", "Last Name", "Age"};
        Object[][] obj = new Object[list.size()][4];

        for(int i = 0; i < list.size(); i ++){
            obj[i][0] = list.get(i).getId();
            obj[i][1] = list.get(i).getFirstName();
            obj[i][2] = list.get(i).getLastName();
            obj[i][3] = list.get(i).getAge();
        }

        table = new JTable(obj, head);
        table.setBounds(33, 154, 731, 369);

        frame.getContentPane().add(table);

        btnBack = new JButton("Back");

        btnBack.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnBack.setBounds(334, 549, 148, 40);
        frame.getContentPane().add(btnBack);

        JLabel lblNewLabel_1 = new JLabel("ID");
        lblNewLabel_1.setFont(new Font("Tahoma", Font.PLAIN, 20));
        lblNewLabel_1.setBounds(33, 121, 148, 30);
        frame.getContentPane().add(lblNewLabel_1);

        JLabel lblNewLabel_1_1 = new JLabel("FIRST NAME");
        lblNewLabel_1_1.setFont(new Font("Tahoma", Font.PLAIN, 20));
        lblNewLabel_1_1.setBounds(215, 121, 148, 30);
        frame.getContentPane().add(lblNewLabel_1_1);

        JLabel lblNewLabel_1_2 = new JLabel("LAST NAME");
        lblNewLabel_1_2.setFont(new Font("Tahoma", Font.PLAIN, 20));
        lblNewLabel_1_2.setBounds(400, 121, 148, 30);
        frame.getContentPane().add(lblNewLabel_1_2);

        JLabel lblNewLabel_1_3 = new JLabel("AGE");
        lblNewLabel_1_3.setFont(new Font("Tahoma", Font.PLAIN, 20));
        lblNewLabel_1_3.setBounds(604, 121, 148, 30);
        frame.getContentPane().add(lblNewLabel_1_3);


        frame.setVisible(true);
    }

    public static JFrame getFrame() {
        return frame;
    }

    public void addBack2Listener(ActionListener mal){btnBack.addActionListener(mal);}

}
