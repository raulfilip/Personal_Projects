package presentation;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;



public class MainView extends JFrame {

    private static JFrame frame;
    private JButton btnClient;
    private JButton btnProduct;
    private JButton btnOrder;
    private JLabel lblTitle;

    public MainView(){
        frame = new JFrame();

        frame.setBounds(100, 100, 628, 381);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        lblTitle = new JLabel("ORDERS MANAGEMENT");
        lblTitle.setFont(new Font("Tahoma", Font.PLAIN, 25));
        lblTitle.setBounds(173, 31, 263, 40);
        frame.getContentPane().add(lblTitle);

        btnClient = new JButton("Client");
        btnClient.setFont(new Font("Tahoma", Font.PLAIN, 20));
        btnClient.setBounds(68, 174, 104, 55);
        frame.getContentPane().add(btnClient);

        btnProduct = new JButton("Product");
        btnProduct.setFont(new Font("Tahoma", Font.PLAIN, 20));

        btnProduct.setBounds(256, 174, 104, 55);
        frame.getContentPane().add(btnProduct);

        btnOrder = new JButton("Order");
        btnOrder.setFont(new Font("Tahoma", Font.PLAIN, 20));

        btnOrder.setBounds(437, 174, 104, 55);
        frame.getContentPane().add(btnOrder);

        frame.setVisible(true);
    }

    public JButton getBtnClient() {
        return btnClient;
    }

    public JButton getBtnProduct() {
        return btnProduct;
    }

    public JButton getBtnOrder() {
        return btnOrder;
    }

    public static JFrame getFrame() {
        return frame;
    }

    public void addClientListener(ActionListener mal){btnClient.addActionListener(mal);}
    public void addProductListener(ActionListener mal){btnProduct.addActionListener(mal);}
    public void addOrderListener(ActionListener mal){btnOrder.addActionListener(mal);}

}
