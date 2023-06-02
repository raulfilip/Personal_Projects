package org.example.model;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;





public  class Polinom {

    HashMap<Integer, Double> elementePolinom = new HashMap<Integer, Double>();

    public Polinom(HashMap<Integer, Double> elementePolinom) {

        this.elementePolinom = elementePolinom;
    }

    public Polinom() {

    }

    public Polinom extragerePolinom(String polynomial) {

        Polinom polinomNou=new Polinom();
        Pattern pattern = Pattern.compile("([+-]?\\d*\\.?\\d*)x\\^(\\d+)|([+-]?\\d+\\.?\\d*)x|([+-]?\\d+\\.?\\d*)");
        Matcher matcher = pattern.matcher(polynomial);

        while (matcher.find()) {
            String coefficientStr = matcher.group(1);
            String exponentStr = matcher.group(2);
            String xTermStr = matcher.group(3);

            if (coefficientStr != null && exponentStr != null) {
                Double coefficient = Double.parseDouble(coefficientStr);
                Integer exponent = Integer.parseInt(exponentStr);
                polinomNou.adaugaElement(exponent,coefficient);
                System.out.println("coefficient: " + coefficient + ", exponent: " + exponent);
            } else if (coefficientStr != null || xTermStr != null) {

                    Double coefficient = (coefficientStr != null) ? Double.parseDouble(coefficientStr) :1.0;
                    Integer exponent = (xTermStr != null) ? 1 : 0;
                    System.out.println("coefficient: " + coefficient + ", exponent: " + exponent);

            } else {
                Double constantTerm = Double.parseDouble(matcher.group(4));
                polinomNou.adaugaElement(0,constantTerm);
                System.out.println("constant term: " + constantTerm);
            }
        }

        return polinomNou;
    }

        public void adaugaElement (Integer exponent, Double coeficient){

            if (this.elementePolinom.containsKey(exponent)) {
                this.elementePolinom.replace(exponent, this.elementePolinom.get(exponent) + coeficient);
            } else {
                this.elementePolinom.put(exponent, coeficient);
            }
            if(this.elementePolinom.containsValue(0))
            {
                for (Map.Entry<Integer,Double>  element2: this.elementePolinom.entrySet()) {
                    if (element2.getValue().intValue()==0) {
                        this.elementePolinom.remove(element2.getKey());
                    }
                }
            }


        }

    public String tostring () {
        String polinomTXT=new String();
        for (Map.Entry<Integer, Double> element1 : this.elementePolinom.entrySet()) {
            if (element1.getValue() > 0) {
                System.out.print(" + " + element1.getValue() + "x^" + element1.getKey());
                polinomTXT = polinomTXT + " + " + element1.getValue() + "x^" + element1.getKey();
            }
            else {
                if (element1.getValue() < 0) {
                    System.out.print(" " + element1.getValue() + "x^" + element1.getKey());
                    polinomTXT = polinomTXT + " " + element1.getValue() + "x^" + element1.getKey();
                }

            }


        }
        if(polinomTXT.isBlank())
        {
            return "0";
        }
        else
            return polinomTXT;
    }

        public void scriePolinom () {

            for (Map.Entry<Integer, Double> element1 : this.elementePolinom.entrySet()) {
                if (element1.getValue() > 0)
                    System.out.print(" + " + element1.getValue() + "x^" + element1.getKey());
                else {
                    if (element1.getValue() < 0) {
                        System.out.print(" " + element1.getValue() + "x^" + element1.getKey());
                    }

                }


            }
            System.out.println();
        }

    }