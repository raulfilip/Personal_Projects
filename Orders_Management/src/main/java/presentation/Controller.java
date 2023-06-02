package presentation;

import bll.ClientBLL;
import bll.ComandaBLL;
import bll.ProdusBLL;
import model.Client;
import model.Produs;
import model.Comanda;

import javax.swing.*;
import java.util.ArrayList;



public class Controller {
    private MainView mainView;
    private SecondView secondView;
    private AddView addView;
    private DeleteView deleteView;
    private UpdateView updateView;
    private AddOrder addOrder;
    ClientBLL clientBLL = new ClientBLL();
    ProdusBLL produsBLL = new ProdusBLL();
    ComandaBLL orderBLL = new ComandaBLL();

    public Controller() {
        mainView = new MainView();
        mainView.addClientListener(e->{
            secondView = new SecondView("CLIENTS");
            secondView.addInsertListener(e1->{
                addView = new AddView("INSERT CLIENTS", "id:", "First name:", "Last name:", "age:");
                addView.addInsert2Listener(e2->{
                    int id = Integer.parseInt(addView.getField1().getText());
                    String firstName = addView.getField2().getText();
                    String lastName = addView.getField3().getText();
                    int age = Integer.parseInt(addView.getField4().getText());
                    clientBLL.insertClient(new Client(id, firstName, lastName, age));
                });

                addView.addBack2Listener(e2->{
                    addView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
            secondView.addDeleteListener(e1->{
                deleteView = new DeleteView("DELETE CLIENTS", "Delete");
                deleteView.addDelete2Listener(e2->{
                    int id = Integer.parseInt(deleteView.getTextId().getText());
                    clientBLL.deleteClient(id);
                });

                deleteView.addBack2Listener(e2->{
                    deleteView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
            secondView.addUpdateListener(e1->{
                updateView = new UpdateView("UPDATE CLIENTS", "id:", "First name:", "Last name:", "age:");
                updateView.addUpdate2Listener(e2->{
                    int id = Integer.parseInt(updateView.getField1().getText());
                    String firstName = updateView.getField2().getText();
                    String lastName = updateView.getField3().getText();
                    int age;
                    if(!updateView.getField4().getText().equals(""))
                        age = Integer.parseInt(updateView.getField4().getText());
                    else
                        age  = clientBLL.findById(id).getAge();

                    if(!updateView.getField2().getText().equals(""))
                        clientBLL.updateClient("firstName", firstName, id);
                    else
                        clientBLL.updateClient("firstName", clientBLL.findById(id).getFirstName(), id);
                    if(!updateView.getField3().getText().equals(""))
                        clientBLL.updateClient("lastName", lastName, id);
                    else
                        clientBLL.updateClient("lastName", clientBLL.findById(id).getLastName(), id);

                    clientBLL.updateClient("age", String.valueOf(age), id);
                    });

                updateView.addBack2Listener(e2->{
                    updateView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });

            });
            secondView.addBackListener(e1->{
                secondView.getFrame().setVisible(false);
                mainView.getFrame().setVisible(true);
            });
            secondView.addShowListener(e1->{
                ViewClients viewClients = new ViewClients(clientBLL.findAll());
                viewClients.addBack2Listener(e2->{
                    viewClients.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
        });
        mainView.addProductListener(e->{
            secondView = new SecondView("PRODUCTS");

            secondView.addInsertListener(e1->{
                addView = new AddView("INSERT PRODUCTS", "id:", "price:", "quantity:", "Name:");

                addView.addInsert2Listener(e2->{
                    int id = Integer.parseInt(addView.getField1().getText());
                    int price = Integer.parseInt(addView.getField2().getText());
                    int quantity = Integer.parseInt(addView.getField3().getText());
                    String name = addView.getField4().getText();
                    produsBLL.insertProdus(new Produs(id, price, quantity, name));
                });

                addView.addBack2Listener(e2->{
                    addView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
            secondView.addDeleteListener(e1->{
                deleteView = new DeleteView("DELETE PRODUCTS", "Delete");

                deleteView.addDelete2Listener(e2->{
                    int id = Integer.parseInt(deleteView.getTextId().getText());
                    produsBLL.deleteProdus(id);
                });

                deleteView.addBack2Listener(e2->{
                    deleteView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });

            secondView.addUpdateListener(e1->{
                updateView = new UpdateView("UPDATE PRODUCTS", "id:", "price:", "quantity:", "Name:");

                updateView.addUpdate2Listener(e2->{
                    int id = Integer.parseInt(updateView.getField1().getText());
                    int price;
                    if(!updateView.getField2().getText().equals(""))
                        price = Integer.parseInt(updateView.getField2().getText());
                    else
                        price = produsBLL.findById(id).getPrice();
                    int quantity;
                    if(!updateView.getField3().getText().equals(""))
                        quantity = Integer.parseInt(updateView.getField3().getText());
                    else
                        quantity = produsBLL.findById(id).getQuantity();
                    String name = updateView.getField4().getText();

                    produsBLL.updateProdus("price", String.valueOf(price), id);
                    produsBLL.updateProdus("quantity", String.valueOf(quantity), id);
                    if(!updateView.getField4().getText().equals(""))
                        produsBLL.updateProdus("name", name, id);
                    else
                        produsBLL.updateProdus("name", produsBLL.findById(id).getName(), id);
                });

                updateView.addBack2Listener(e2->{
                    updateView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });

            });

            secondView.addBackListener(e1->{
                secondView.getFrame().setVisible(false);
                mainView.getFrame().setVisible(true);
            });

            secondView.addShowListener(e1->{
                ViewProducts viewProducts = new ViewProducts(produsBLL.findAll());
                viewProducts.addBack2Listener(e2->{
                    viewProducts.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
        });
        mainView.addOrderListener(e->{
            secondView = new SecondView("ORDERS");

            secondView.addInsertListener(e1->{

                ArrayList<Client> list1 = clientBLL.findAll();
                ArrayList<Produs> list2 = produsBLL.findAll();

                String[] listC = new String[list1.size()];
                String[] listP = new String[list2.size()];

                for(int i = 0; i < list1.size(); i ++){
                    listC[i] = list1.get(i).getId() + "";
                }

                for(int i = 0; i < list2.size(); i ++){
                    listP[i] = list2.get(i).getId() + "";
                }

                addOrder = new AddOrder("INSERT ORDERS", listC, listP);

                addOrder.addInsert3Listener(e2->{
                    int id = Integer.parseInt(addOrder.getField1().getText());
                    int clientId = Integer.parseInt((String) addOrder.getComboBoxC().getSelectedItem());
                    int productId = Integer.parseInt((String) addOrder.getComboBoxP().getSelectedItem());
                    int quantity = Integer.parseInt(addOrder.getField4().getText());

                    if(produsBLL.findById(productId).getQuantity() >= quantity) {
                        orderBLL.insertOrder(new Comanda(id, clientId, productId, quantity));

                        if(produsBLL.findById(productId).getQuantity() - quantity == 0)
                            produsBLL.deleteProdus(productId);
                        else
                            produsBLL.updateProdus("quantity", String.valueOf(produsBLL.findById(productId).getQuantity() - quantity), productId);

                    }

                    else
                        JOptionPane.showMessageDialog(addOrder, "Cantitatea ceruta nu este disponibila!\nCantitate disponibila: " + produsBLL.findById(productId).getQuantity(), "Error", JOptionPane.ERROR_MESSAGE);

                });

                addOrder.addBack2Listener(e2->{
                    addOrder.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
            secondView.addDeleteListener(e1->{
                deleteView = new DeleteView("DELETE ORDERS", "Delete");

                deleteView.addDelete2Listener(e2->{
                    int id = Integer.parseInt(deleteView.getTextId().getText());
                    orderBLL.deleteOrder(id);
                });

                deleteView.addBack2Listener(e2->{
                    deleteView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });

            secondView.addUpdateListener(e1->{
                updateView = new UpdateView("UPDATE ORDERS", "id:", "client id:", "product id:","quantity:");

                updateView.addUpdate2Listener(e2->{
                    int id = Integer.parseInt(updateView.getField1().getText());
                    int clientId;
                    if(!updateView.getField2().getText().equals(""))
                        clientId = Integer.parseInt(updateView.getField2().getText());
                    else
                        clientId = orderBLL.findById(id).getClientId();
                    int productId;
                    if(!updateView.getField3().getText().equals(""))
                          productId = Integer.parseInt(updateView.getField3().getText());
                    else
                        productId = orderBLL.findById(id).getProductId();
                    int quantity;
                    if(!updateView.getField4().getText().equals(""))
                        quantity = Integer.parseInt(updateView.getField4().getText());
                    else
                        quantity = orderBLL.findById(id).getQuantity();

                    orderBLL.updateOrder("clientId", String.valueOf(clientId), id);
                    orderBLL.updateOrder("productId", String.valueOf(productId), id);
                    orderBLL.updateOrder("quantity", String.valueOf(quantity), id);
                });

                updateView.addBack2Listener(e2->{
                    updateView.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });

            });

            secondView.addBackListener(e1->{
                secondView.getFrame().setVisible(false);
                mainView.getFrame().setVisible(true);
            });

            secondView.addShowListener(e1 -> {
                ViewOrder viewOrder = new ViewOrder(orderBLL.findAll());
                viewOrder.addBack2Listener(e2->{
                    viewOrder.getFrame().setVisible(false);
                    secondView.getFrame().setVisible(true);
                });
            });
        });
    }
}
