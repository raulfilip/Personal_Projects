package org.tests;

import org.example.model.Operatii;
import org.example.model.Polinom;
import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

class OperatiiTest {
    @Test
    public void testAdunare(){
        Polinom a=new Polinom();
        a.extragerePolinom("2x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("2x^2+3");
        Polinom c=new Polinom();
        c.extragerePolinom("4x^2+6");
        Assert.assertEquals(Operatii.adunare(a,b).tostring(),c.tostring());
    }
    @Test
    public void testScadere(){
        Polinom a=new Polinom();
        a.extragerePolinom("2x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("2x^2+3");
        Polinom c=new Polinom();
        c.extragerePolinom("0");
        assertEquals(Operatii.scadere(a,b).tostring(),c.tostring());
    }
    @Test
    public void testImpartire(){
        Polinom a=new Polinom();
        a.extragerePolinom("2x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("2x^2+3");
        assertEquals(Operatii.impartire(a,b),"Cat: +1.0x^0 Rest:0");
    }
    @Test
    public void testInmultire(){
        Polinom a=new Polinom();
        a.extragerePolinom("2x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("1x^2");
        Polinom c=new Polinom();
        c.extragerePolinom("2x^4+3x^2");
        assertEquals(Operatii.inmultire(a,b).tostring(),c.tostring());
    }
    @Test
    public void testDerivare(){
        Polinom a=new Polinom();
        a.extragerePolinom("2x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("4x^1");

        assertEquals(Operatii.derivare(a).tostring(),b.tostring());
    }
    @Test
    public void testIntegrare(){
        Polinom a=new Polinom();
        a.extragerePolinom("3x^2+3");
        Polinom b=new Polinom();
        b.extragerePolinom("3x^1+1x^3");

        assertEquals(Operatii.integrare(a).tostring(),b.tostring());
    }
//@Test
//    public void main(){
//    Polinom a=new Polinom();
//    a.extragerePolinom("3x^2+3");
//    Polinom b=new Polinom();
//    b.extragerePolinom("3x^1+1x^3");
//    Operatii op=new Operatii();
//    assertEquals(op.integrare(a).tostring(),b.tostring());
//
//
//    }
}