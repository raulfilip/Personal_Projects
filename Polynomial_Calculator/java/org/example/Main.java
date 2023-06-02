package org.example;

import org.example.model.Operatii;
import org.example.model.Polinom;

public class Main {
    public static void main(String[] args) {
        Polinom polinomtest=new Polinom();
        polinomtest=polinomtest.extragerePolinom("3x^2-1x^1+1.25");
        Polinom polinom1=new Polinom();
        Polinom polinom2=new Polinom();
        Polinom rezultat=new Polinom();
        Operatii op=new Operatii();
        Integer exponent= Integer.valueOf(3);
        Double coeficient= Double.valueOf(2);
        polinom1.adaugaElement(exponent,coeficient);
        exponent=4;
        coeficient=Double.valueOf(7);
        polinom1.adaugaElement(exponent,coeficient);
        polinom1.adaugaElement(1,Double.valueOf(3));
        polinom1.adaugaElement(1,Double.valueOf(4));
        polinom2.adaugaElement(4,Double.valueOf(3));
        polinom2.adaugaElement(2,Double.valueOf(4));
        System.out.println("polinom 1");
        polinom1.scriePolinom();
        System.out.println("polinom 2");
        polinom2.scriePolinom();
        System.out.println("adunare");
        rezultat=op.adunare(polinom1,polinom2);
        rezultat.scriePolinom();
        System.out.println("scadere");
        rezultat=op.scadere(polinom1,polinom2);
        rezultat.scriePolinom();
        System.out.println("inmultire");
        rezultat=op.inmultire(polinom1,polinom2);
        rezultat.scriePolinom();
        System.out.println("derivare");
        rezultat=op.derivare(polinom1);
        rezultat.scriePolinom();
        System.out.println("integrare");
        rezultat=op.integrare(polinom2);
        rezultat.scriePolinom();
    }
    }
