package bll;

import dao.ComandaDAO;
import model.Comanda;
import java.util.ArrayList;
import java.util.NoSuchElementException;


public class ComandaBLL {

    private ComandaDAO orderDAO;

    public ComandaBLL() {
        orderDAO = new ComandaDAO();
    }


    public Comanda insertOrder(Comanda order) {
        return orderDAO.insert(order);
    }


    public void deleteOrder(int id) {
        orderDAO.delete(id);
    }


    public void updateOrder(String field, String value, int id) {
        orderDAO.update(field, value, id);
    }



    public Comanda findById(int id) {
        Comanda st = orderDAO.findById(id);
        if (st == null) {
            throw new NoSuchElementException("The order with id =" + id + " was not found!");
        }
        return st;
    }


    public ArrayList<Comanda> findAll(){
        ArrayList<Comanda> list = new ArrayList<Comanda>();
        list = (ArrayList<Comanda>) orderDAO.findAll();

        return list;
    }
}
