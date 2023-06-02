package bll;

import dao.ProdusDAO;
import model.Produs;
import java.util.ArrayList;
import java.util.NoSuchElementException;



public class ProdusBLL {
    private ProdusDAO produsDAO;
    public ProdusBLL() {
        produsDAO = new ProdusDAO();
    }


    public Produs insertProdus(Produs produs) {
        return produsDAO.insert(produs);
    }


    public void deleteProdus(int id) {
        produsDAO.delete(id);
    }


    public void updateProdus(String field, String value, int id) {
        produsDAO.update(field, value, id);
    }


    public Produs findById(int id) {
        Produs st = produsDAO.findById(id);
        if (st == null) {
            throw new NoSuchElementException("The produs with id =" + id + " was not found!");
        }
        return st;
    }


    public ArrayList<Produs> findAll(){
        ArrayList<Produs> list = new ArrayList<Produs>();
        list = (ArrayList<Produs>) produsDAO.findAll();

        for(int i = 0; i < list.size(); i ++){
            if(list.get(i).getQuantity() == 0){
                list.remove(i);
                i --;
            }
        }

        return list;
    }
}
