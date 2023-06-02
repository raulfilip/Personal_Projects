package start;

import bll.ComandaBLL;
import model.Comanda;
import presentation.Controller;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;



public class Start {
    public static void main(String[] args) {
        Controller controller = new Controller();
        ComandaBLL orderBLL = new ComandaBLL();

        ArrayList<Comanda> list = new ArrayList<Comanda>();
        list = orderBLL.findAll();

        FileWriter myWriter = null;
        try {
            myWriter = new FileWriter("bill.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
        PrintWriter printWriter = new PrintWriter(myWriter);


        for(int i = 0; i < list.size(); i ++){

            printWriter.print("BILL " + (i + 1) + "\n");
            printWriter.print("ID:"+ list.get(i).getId() + "\n");
            printWriter.print("Client ID:" + list.get(i).getClientId() + "\n");
            printWriter.print("Produs ID:" + list.get(i).getProductId() + "\n");
            printWriter.print("Cantitate:" + list.get(i).getQuantity() + "\n");
            printWriter.print("\n");
        }

        printWriter.close();
    }
}
