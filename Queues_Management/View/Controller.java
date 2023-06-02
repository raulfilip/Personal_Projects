package org.example;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import pachet2.SimulationManager;

public class Controller {
    private SimulationFrame view;
    private SimulationManager sim;

    public Controller(SimulationFrame view) {
        this.view = view;
        view.addStartListener((e) -> {
            int time = Integer.parseInt(view.getUserTimeLimit());
            int maxArrival = Integer.parseInt(view.getUserMaxArrivalTime());
            int minArrival = Integer.parseInt(view.getUserMinArrivalTime());
            int minService = Integer.parseInt(view.getUserMinProcessingTime());
            int maxSerivce = Integer.parseInt(view.getUserMaxProcessingTime());
            int nrClients = Integer.parseInt(view.getUserNumberOfClients());
            int nrQueues = Integer.parseInt(view.getUserNumberOfQueues());
            String strategyChoice = (String)view.getStrategyChoice().getSelectedItem();
            this.sim = new SimulationManager(maxArrival, minArrival, maxSerivce, minService, nrClients, nrQueues, time, strategyChoice);
            Thread t = new Thread(this.sim);
            t.start();
        });
        view.addResetListener((e) -> {
            view.getMaxArrivalTime().setText("");
            view.getTimeLimit().setText("");
            view.getMaxProcessingTime().setText("");
            view.getMinArrivalTime().setText("");
            view.getMinProcessingTime().setText("");
            view.getNumberOfClients().setText("");
            view.getNumberOfServers().setText("");
            SimulationFrame.getTextArea().setText("");
        });
    }

    public SimulationManager getSim() {
        return this.sim;
    }
}
