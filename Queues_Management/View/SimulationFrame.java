package org.example;
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import java.awt.Font;
import java.awt.LayoutManager;
import java.awt.event.ActionListener;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

public class SimulationFrame extends JFrame {
    private JFrame frame = new JFrame();
    private JTextField timeLimit;
    private JLabel timeLimitLabel;
    private JTextField maxProcessingTime;
    private JLabel maxProcessingTimeLabel;
    private JTextField minProcessingTime;
    private JLabel minProcessingTimeLabel;
    private JTextField maxArrivalTime;
    private JLabel maxArrivalTimeLabel;
    private JTextField minArrivalTime;
    private JLabel minArrivalTimeLabel;
    private JTextField numberOfClients;
    private JLabel numberOfClientsLabel;
    private JTextField numberOfServers;
    private JLabel numberOfServersLabel;
    private JButton start;
    private JComboBox strategyChoice;
    private JLabel startegyChoiceLabel;
    private static JTextArea textArea;
    private JScrollPane scrollBar;
    private JButton reset;

    public SimulationFrame() {
        this.frame.setBounds(0, 0, 1055, 648);
        this.frame.setDefaultCloseOperation(3);
        this.frame.getContentPane().setLayout((LayoutManager)null);
        this.timeLimit = new JTextField();
        this.timeLimit.setBounds(271, 18, 146, 36);
        this.frame.getContentPane().add(this.timeLimit);
        this.timeLimit.setColumns(10);
        this.timeLimitLabel = new JLabel("Simulation time =");
        this.timeLimitLabel.setFont(new Font("Tahoma", 0, 20));
        this.timeLimitLabel.setBounds(98, 17, 172, 38);
        this.frame.getContentPane().add(this.timeLimitLabel);
        this.maxProcessingTime = new JTextField();
        this.maxProcessingTime.setBounds(271, 64, 146, 36);
        this.frame.getContentPane().add(this.maxProcessingTime);
        this.maxProcessingTime.setColumns(10);
        this.maxProcessingTimeLabel = new JLabel("Maximum processing time =");
        this.maxProcessingTimeLabel.setFont(new Font("Tahoma", 0, 20));
        this.maxProcessingTimeLabel.setBounds(10, 70, 282, 29);
        this.frame.getContentPane().add(this.maxProcessingTimeLabel);
        this.minProcessingTime = new JTextField();
        this.minProcessingTime.setBounds(727, 64, 146, 36);
        this.frame.getContentPane().add(this.minProcessingTime);
        this.minProcessingTime.setColumns(10);
        this.minProcessingTimeLabel = new JLabel("Minimum processing time =");
        this.minProcessingTimeLabel.setFont(new Font("Tahoma", 0, 20));
        this.minProcessingTimeLabel.setBounds(467, 70, 262, 29);
        this.frame.getContentPane().add(this.minProcessingTimeLabel);
        this.maxArrivalTime = new JTextField();
        this.maxArrivalTime.setColumns(10);
        this.maxArrivalTime.setBounds(271, 118, 146, 36);
        this.frame.getContentPane().add(this.maxArrivalTime);
        this.maxArrivalTimeLabel = new JLabel("Maximum arrival time =");
        this.maxArrivalTimeLabel.setFont(new Font("Tahoma", 0, 20));
        this.maxArrivalTimeLabel.setBounds(43, 118, 227, 29);
        this.frame.getContentPane().add(this.maxArrivalTimeLabel);
        this.minArrivalTime = new JTextField();
        this.minArrivalTime.setColumns(10);
        this.minArrivalTime.setBounds(727, 111, 146, 36);
        this.frame.getContentPane().add(this.minArrivalTime);
        this.minArrivalTimeLabel = new JLabel("Minimum arrival time =");
        this.minArrivalTimeLabel.setFont(new Font("Tahoma", 0, 20));
        this.minArrivalTimeLabel.setBounds(499, 118, 214, 29);
        this.frame.getContentPane().add(this.minArrivalTimeLabel);
        this.numberOfClients = new JTextField();
        this.numberOfClients.setColumns(10);
        this.numberOfClients.setBounds(271, 165, 146, 36);
        this.frame.getContentPane().add(this.numberOfClients);
        this.numberOfClientsLabel = new JLabel("Number of clients =");
        this.numberOfClientsLabel.setFont(new Font("Tahoma", 0, 20));
        this.numberOfClientsLabel.setBounds(79, 165, 191, 29);
        this.frame.getContentPane().add(this.numberOfClientsLabel);
        this.numberOfServers = new JTextField();
        this.numberOfServers.setColumns(10);
        this.numberOfServers.setBounds(727, 158, 146, 36);
        this.frame.getContentPane().add(this.numberOfServers);
        this.numberOfServersLabel = new JLabel("Number of queues =");
        this.numberOfServersLabel.setFont(new Font("Tahoma", 0, 20));
        this.numberOfServersLabel.setBounds(522, 165, 191, 29);
        this.frame.getContentPane().add(this.numberOfServersLabel);
        this.start = new JButton("Start");
        this.start.setFont(new Font("Tahoma", 0, 20));
        this.start.setBounds(331, 228, 146, 36);
        this.frame.getContentPane().add(this.start);
        this.reset = new JButton("Reset");
        this.reset.setFont(new Font("Tahoma", 0, 20));
        this.reset.setBounds(521, 228, 146, 36);
        this.frame.getContentPane().add(this.reset);
        this.strategyChoice = new JComboBox();
        this.strategyChoice.setModel(new DefaultComboBoxModel(new String[]{"SHORTEST_TIME", "SHORTEST_QUEUE"}));
        this.strategyChoice.setSelectedIndex(1);
        this.strategyChoice.setFont(new Font("Tahoma", 0, 20));
        this.strategyChoice.setBounds(716, 14, 209, 36);
        this.frame.getContentPane().add(this.strategyChoice);
        this.startegyChoiceLabel = new JLabel("Choose the strategy:");
        this.startegyChoiceLabel.setFont(new Font("Tahoma", 0, 20));
        this.startegyChoiceLabel.setBounds(515, 14, 191, 38);
        this.frame.getContentPane().add(this.startegyChoiceLabel);
        textArea = new JTextArea();
        textArea.setBounds(10, 286, 1004, 314);
        textArea.setEditable(false);
        this.scrollBar = new JScrollPane(textArea);
        this.scrollBar.setVerticalScrollBarPolicy(22);
        this.scrollBar.setBounds(10, 296, 1004, 318);
        this.frame.getContentPane().add(this.scrollBar);
        this.frame.setVisible(true);
    }

    String getUserTimeLimit() {
        return this.timeLimit.getText();
    }

    String getUserMaxProcessingTime() {
        return this.maxProcessingTime.getText();
    }

    String getUserMinProcessingTime() {
        return this.minProcessingTime.getText();
    }

    String getUserMaxArrivalTime() {
        return this.maxArrivalTime.getText();
    }

    String getUserMinArrivalTime() {
        return this.minArrivalTime.getText();
    }

    String getUserNumberOfClients() {
        return this.numberOfClients.getText();
    }

    String getUserNumberOfQueues() {
        return this.numberOfServers.getText();
    }

    public void addStartListener(ActionListener mal) {
        this.start.addActionListener(mal);
    }

    public void addResetListener(ActionListener mal) {
        this.reset.addActionListener(mal);
    }

    public JTextField getTimeLimit() {
        return this.timeLimit;
    }

    public JTextField getMaxProcessingTime() {
        return this.maxProcessingTime;
    }

    public JTextField getMinProcessingTime() {
        return this.minProcessingTime;
    }

    public JTextField getMaxArrivalTime() {
        return this.maxArrivalTime;
    }

    public JTextField getMinArrivalTime() {
        return this.minArrivalTime;
    }

    public JTextField getNumberOfServers() {
        return this.numberOfServers;
    }

    public JTextField getNumberOfClients() {
        return this.numberOfClients;
    }

    public JComboBox getStrategyChoice() {
        return this.strategyChoice;
    }

    public static JTextArea getTextArea() {
        return textArea;
    }
}
