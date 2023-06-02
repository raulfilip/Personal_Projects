package org.example.view;

import org.example.model.Operatii;
import org.example.model.Polinom;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GUI {


    public GUI(){
        JFrame frame=new JFrame();
        JPanel panel=new JPanel();

        JButton buttonAdunare=new JButton("Adunare");
        JButton buttonScadere=new JButton("Scadere");
        JButton buttonInmultire=new JButton("Inmultire");
        JButton buttonImpartire=new JButton("Impartire");
        JButton buttonIntegrareP1=new JButton("Integrare Prim Polinom");
        JButton buttonIntegrareP2=new JButton("Integrare al Doilea Polinom");
        JButton buttonDerivareP1=new JButton("Derivare Prim Polinom");
        JButton buttonDerivareP2=new JButton("Derivare al Doilea Polinom");
        JLabel labelAvertisment=new JLabel("Atentie! Pentru o buna functionare a aplicatiei, va rugam sa tineti cont de urmatoarele cerinte: ");
        JLabel labelCerinta1=new JLabel("1: nu lasati spatii intre semne si coeficienti");
        JLabel labelCerinta2=new JLabel("2: daca polinomul are coeficientul sau exponentul 1, va rugam sa scrieti acest lucru explicit dupa modelul: 1x^1");
        JLabel labelMultumiri=new JLabel("Multumim pentru intelegere!:*");
        JLabel labelp1=new JLabel("Primul Polinom");
        JLabel labelp2=new JLabel("Al Dpoilea Polinom");
        JLabel labelr=new JLabel("Rezultat");
        JLabel labelScriereRezultat=new JLabel();
        JTextField textPolinom1=new JTextField();
        JTextField textPolinom2=new JTextField();

        panel.setBorder(BorderFactory.createEmptyBorder(30,30,30,30));
        frame.setSize(640,480);
        panel.setLayout(new GridLayout(0,1));
        panel.add(labelAvertisment);
        panel.add(labelCerinta1);
        panel.add(labelCerinta2);
        panel.add(labelMultumiri);
        panel.add(labelp1);
        panel.add(textPolinom1);
        panel.add(labelp2);
        panel.add(textPolinom2);
        panel.add(labelr);
        panel.add(labelScriereRezultat);
        panel.add(buttonAdunare);
        panel.add(buttonScadere);
        panel.add(buttonInmultire);
        panel.add(buttonImpartire);
        panel.add(buttonIntegrareP1);
        panel.add(buttonIntegrareP2);
        panel.add(buttonDerivareP1);
        panel.add(buttonDerivareP2);
        frame.add(panel,BorderLayout.CENTER);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setTitle("Calculator de Polinoame");
        frame.pack();
        buttonAdunare.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                Polinom polinom2=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.adunare(polinom1,polinom2);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Adunare:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });

        buttonScadere.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                Polinom polinom2=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.scadere(polinom1,polinom2);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Scadere:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });
        buttonInmultire.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                Polinom polinom2=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.inmultire(polinom1,polinom2);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Inmultire:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });
        buttonImpartire.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                Polinom polinom2=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat.scriePolinom();
                labelr.setText("Rezultat Impartire:");
                labelScriereRezultat.setText(op.impartire(polinom1,polinom2));

            }

        });
        buttonIntegrareP1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.integrare(polinom1);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Integrare Prim Polinom:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });
        buttonIntegrareP2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom2=new Polinom();
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.integrare(polinom2);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Integrare al Doilea Polinom:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });
        buttonDerivareP1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom1=new Polinom();
                polinom1=polinom1.extragerePolinom(textPolinom1.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.derivare(polinom1);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Derivare Prim Polinom:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });
        buttonDerivareP2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Polinom polinom2=new Polinom();
                polinom2=polinom2.extragerePolinom(textPolinom2.getText());
                Polinom rezultat=new Polinom();
                Operatii op=new Operatii();
                rezultat=op.derivare(polinom2);
                rezultat.scriePolinom();
                labelr.setText("Rezultat Derivare al Doilea Polinom:");
                labelScriereRezultat.setText(rezultat.tostring());

            }

        });


        frame.setVisible(true);
    }
    public static void main(String[] args) {
        new GUI();
    }

}
