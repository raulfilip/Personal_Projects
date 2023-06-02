package org.example.model;

import java.util.Map;

public class Operatii {

    public Operatii() {

    }

    public static Polinom adunare(Polinom polinom1, Polinom polinom2) {
        Polinom polinom3 = new Polinom();
        for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {
            polinom3.adaugaElement(element1.getKey(), element1.getValue());
        }
        for (Map.Entry<Integer, Double> element2 : polinom2.elementePolinom.entrySet()) {
            polinom3.adaugaElement(element2.getKey(), element2.getValue());
        }

        return polinom3;

    }

    public static Polinom scadere(Polinom polinom1, Polinom polinom2) {
        Polinom polinom3 = new Polinom();
        for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {
            polinom3.adaugaElement(element1.getKey(), element1.getValue());
        }
        for (Map.Entry<Integer, Double> element2 : polinom2.elementePolinom.entrySet()) {
            polinom3.adaugaElement(element2.getKey(), -1 * element2.getValue());
        }

        return polinom3;

    }

    public static Polinom inmultire(Polinom polinom1, Polinom polinom2) {
        Polinom polinom3 = new Polinom();
        for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {

            for (Map.Entry<Integer, Double> element2 : polinom2.elementePolinom.entrySet()) {

                polinom3.adaugaElement(element1.getKey() + element2.getKey(), element1.getValue() * element2.getValue());
            }
        }
        return polinom3;

    }

    public static String impartire(Polinom polinom1, Polinom polinom2) {
        Polinom impartitor = new Polinom();
        Polinom deimpartit = new Polinom();
        Polinom rest = new Polinom();
        Polinom cat = new Polinom();
        Integer gradMaximP1 = 0;
        Integer gradMaximP2 = 0;
        Operatii op = new Operatii();
        //gasire grade maxime polinoame pentru a decide care este deimpartitul si care este impartitorul
        for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {
            if (element1.getKey() > gradMaximP1) {
                gradMaximP1 = element1.getKey();
            }
        }

        for (Map.Entry<Integer, Double> element2 : polinom2.elementePolinom.entrySet()) {
            if (element2.getKey() > gradMaximP2) {
                gradMaximP2 = element2.getKey();
            }
        }
        if (gradMaximP1 > gradMaximP2) {
            deimpartit = polinom1;
            impartitor = polinom2;
        } else {
            deimpartit = polinom2;
            impartitor = polinom1;
            Integer aux = gradMaximP1;
            gradMaximP1 = gradMaximP2;
            gradMaximP2 = aux;
        }
        int k=0;
            //de acum gradmaxp1 va reprezenta gradul deimpartitului si gradmaxp2 gradul impartitorului
        Polinom monomMaxImpartitor = new Polinom();
        if(gradMaximP2==0)
        {
            for (Map.Entry<Integer, Double> element1 : deimpartit.elementePolinom.entrySet()) {

                    cat.adaugaElement(element1.getKey(), (double)(element1.getValue()/impartitor.elementePolinom.get(0).intValue()));

                }
            }
        else {
            while (gradMaximP1 >= gradMaximP2) {
                // selectare monoame cu grad maxim;
                Polinom quotient = new Polinom();
                Polinom monomMaxDeimpartit = new Polinom();
                Polinom polinomAuxiliar = new Polinom();// ne va ajuta la obtinerea noului deimpartit
                for (Map.Entry<Integer, Double> element1 : deimpartit.elementePolinom.entrySet()) {
                    if (element1.getKey() == (gradMaximP1)) {
                        monomMaxDeimpartit.adaugaElement(element1.getKey(), element1.getValue());
                    }
                }
                if (k == 0) {
                    for (Map.Entry<Integer, Double> element2 : impartitor.elementePolinom.entrySet()) {
                        if (element2.getKey().intValue() == gradMaximP2.intValue()) {
                            monomMaxImpartitor.adaugaElement(element2.getKey(), element2.getValue());
                        }
                    }
                    k++;
                }
//impartire monoame dominante intre ele
                for (Map.Entry<Integer, Double> element1 : monomMaxDeimpartit.elementePolinom.entrySet()) {

                    for (Map.Entry<Integer, Double> element2 : monomMaxImpartitor.elementePolinom.entrySet()) {
                        quotient.adaugaElement(element1.getKey() - element2.getKey(), element1.getValue() / element2.getValue());
                        cat.adaugaElement(element1.getKey() - element2.getKey(), element1.getValue() / element2.getValue());
                    }
                }
                polinomAuxiliar = op.inmultire(quotient, impartitor);
                deimpartit = op.scadere(deimpartit, polinomAuxiliar);
                gradMaximP1 = 0;
                for (Map.Entry<Integer, Double> element1 : deimpartit.elementePolinom.entrySet()) {
                    if (element1.getKey() > gradMaximP1 && element1.getValue() != 0) {
                        gradMaximP1 = element1.getKey();
                    }
                }
            }
        }

            String rezultat = new String();
            rezultat = rezultat + "Cat: " + cat.tostring();
            if(gradMaximP2!=0)
                rest=deimpartit;
            rezultat = rezultat + "   Rest:" + rest.tostring();
            return rezultat;
        }

        public static Polinom derivare(Polinom polinom1){
            Polinom polinom3 = new Polinom();
            for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {

                polinom3.adaugaElement(element1.getKey() - 1, element1.getValue() * element1.getKey());

            }


            return polinom3;

        }

        public static Polinom integrare(Polinom polinom1){
            Polinom polinom3 = new Polinom();

            for (Map.Entry<Integer, Double> element1 : polinom1.elementePolinom.entrySet()) {

                polinom3.adaugaElement(element1.getKey() + 1, element1.getValue() / (element1.getKey() + 1));

            }


            return polinom3;

        }


    }

