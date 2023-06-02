package pachet2;
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import pachet1.ConcreteStrategyQueue;
import pachet1.ConcrreteStrategyTime;
import pachet1.SelectionPolicy;
import pachet1.Strategy;
import pachet3.Server;
import pachet3.Task;

import java.util.ArrayList;
import java.util.List;

public class Scheduler {
    private List<Server> servers;
    private int nrMaxNoServers;
    private int maxTasksPerServer;
    private Strategy strategy;

    public Scheduler(int maxNoServers, int maxTasksPerServer) {
        this.nrMaxNoServers = maxNoServers;
        this.maxTasksPerServer = maxTasksPerServer;
        this.servers = new ArrayList();

        for(int i = 0; i < maxNoServers; ++i) {
            Server s = new Server(maxTasksPerServer);
            this.servers.add(s);
            Thread t = new Thread(s);
            t.start();
        }

    }

    public void changeStrategy(SelectionPolicy policy) {
        if (policy == SelectionPolicy.SHORTEST_QUEUE) {
            this.strategy = new ConcreteStrategyQueue();
        }

        if (policy == SelectionPolicy.SHORTEST_TIME) {
            this.strategy = new ConcrreteStrategyTime();
        }

    }

    public void dispatchTask(Task t) {
        this.strategy.addTask(this.servers, t);
    }

    public ArrayList<Server> getServers() {
        return (ArrayList)this.servers;
    }
}
