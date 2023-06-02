package bll;

import dao.ClientDAO;
import model.Client;
import java.util.ArrayList;
import java.util.NoSuchElementException;



public class ClientBLL {
    private ClientDAO clientDAO;
    public ClientBLL() {
        clientDAO = new ClientDAO();
    }


    public Client insertClient(Client client) {
        return clientDAO.insert(client);
    }


    public void deleteClient(int id) {
        clientDAO.delete(id);
    }


    public void updateClient(String field, String value, int id) {
        clientDAO.update(field, value, id);
    }


    public Client findById(int id) {
        Client st = clientDAO.findById(id);
        if (st == null) {
            throw new NoSuchElementException("The client with id =" + id + " was not found!");
        }
        return st;
    }


    public ArrayList<Client> findAll(){
        ArrayList<Client> list = new ArrayList<Client>();
        list = (ArrayList<Client>) clientDAO.findAll();

        return list;
    }
}
