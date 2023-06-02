package pachet2;
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import org.example.SimulationFrame;
import pachet1.SelectionPolicy;
import pachet2.Scheduler;
import pachet3.Server;
import pachet3.Task;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class SimulationManager implements Runnable {
    private int timeLimit;
    private int maxProcessingTime;
    private int minProcessingTime;
    private int maxArrivalTime;
    private int minArrivalTime;
    private int numberOfServers;
    private int numberOfClients;
    private SelectionPolicy selectionPolicy;
    private Scheduler scheduler;
    private List<Task> generatedTasks;
    private float averageWaitingTime;
    private int peekHour;
    private float averageServiceTime;
    public static boolean runVariable = true;

    public SimulationManager(int maxArrivalTime, int minArrivalTime, int maxProcessingTime, int minProcessingTime, int numberOfClients, int numberOfServers, int timeLimit, String selectedStrategy) {
        this.maxArrivalTime = maxArrivalTime;
        this.minArrivalTime = minArrivalTime;
        this.maxProcessingTime = maxProcessingTime;
        this.minProcessingTime = minProcessingTime;
        this.numberOfServers = numberOfServers;
        this.numberOfClients = numberOfClients;
        this.timeLimit = timeLimit;
        this.averageWaitingTime = 0.0F;
        this.peekHour = 0;
        this.averageServiceTime = 0.0F;
        this.selectionPolicy = SelectionPolicy.valueOf(selectedStrategy);
        this.scheduler = new Scheduler(numberOfServers, numberOfClients);
        this.scheduler.changeStrategy(this.selectionPolicy);
        this.generateNRandomTasks();
    }

    private void generateNRandomTasks() {
        Random r = new Random();
        this.generatedTasks = new ArrayList();

        for(int i = 0; i < this.numberOfClients; ++i) {
            this.generatedTasks.add(new Task(r.nextInt(this.maxArrivalTime - this.minArrivalTime) + this.minArrivalTime, r.nextInt(this.maxProcessingTime - this.minProcessingTime) + this.minProcessingTime));
            this.averageWaitingTime += (float)((Task)this.generatedTasks.get(i)).getServiceTime();
        }

        Collections.sort(this.generatedTasks);
        this.averageServiceTime = this.averageWaitingTime / (float)this.numberOfClients;
        this.averageWaitingTime /= (float)(this.numberOfClients * this.numberOfServers);
    }

    public void run() {
        int currentTime = 0;
        int max1 = Integer.MIN_VALUE;

        try {
            FileWriter myWriter = new FileWriter("projectFile.txt");
            PrintWriter printWriter = new PrintWriter(myWriter);
            printWriter.print(this.generatedTasks.toString() + "\n");
            SimulationFrame.getTextArea().append(this.generatedTasks.toString() + "\n");

            for(; currentTime < this.timeLimit; ++currentTime) {
                int ok;
                for(ok = 0; ok < this.generatedTasks.size(); ++ok) {
                    if (((Task)this.generatedTasks.get(ok)).getArrivalTime() == currentTime) {
                        this.scheduler.dispatchTask((Task)this.generatedTasks.get(ok));
                        this.generatedTasks.remove(ok--);
                    }
                }

                SimulationFrame.getTextArea().append("Timp simulare " + currentTime + "\n");
                printWriter.print("Timp simulare " + currentTime + "\n");

                for(ok = 0; ok < this.scheduler.getServers().size(); ++ok) {
                    new String();
                    SimulationFrame.getTextArea().append("Coada " + (ok + 1) + ": ");
                    printWriter.print("Coada " + (ok + 1) + ": ");
                    String print = ((Server)this.scheduler.getServers().get(ok)).getTasks().toString();
                    printWriter.write(print + "\n");
                    SimulationFrame.getTextArea().append(print + "\n");
                }

                ok = 0;
                int sum = 0;

                int i;
                for(i = 0; i < this.scheduler.getServers().size(); ++i) {
                    sum += ((Server)this.scheduler.getServers().get(i)).getTasks().size();
                }

                if (sum > max1) {
                    max1 = sum;
                    this.peekHour = currentTime;
                }

                for(i = 0; i < this.scheduler.getServers().size(); ++i) {
                    if (((Server)this.scheduler.getServers().get(i)).getTasks().size() != 0) {
                        int time = ((Task)((Server)this.scheduler.getServers().get(i)).getTasks().peek()).getServiceTime();
                        if (time != 0) {
                            ((Task)((Server)this.scheduler.getServers().get(i)).getTasks().peek()).setServiceTime(time - 1);
                        } else {
                            ((Server)this.scheduler.getServers().get(i)).deleteTask();
                        }
                    } else {
                        ++ok;
                    }
                }

                if (ok == this.numberOfServers && this.generatedTasks.size() == 0) {
                    runVariable = true;
                    break;
                }

                try {
                    Thread.sleep(1000L);
                } catch (InterruptedException var9) {
                    var9.printStackTrace();
                }
            }

            printWriter.write("Peek hour is " + this.peekHour + ".\n");
            printWriter.write("Average waiting time is " + this.averageWaitingTime + ".\n");
            printWriter.write("Average service time is " + this.averageServiceTime + ".\n");
            printWriter.close();
            SimulationFrame.getTextArea().append("Peek hour is " + this.peekHour + ".\n");
            SimulationFrame.getTextArea().append("Average waiting time is " + this.averageWaitingTime + ".\n");
            SimulationFrame.getTextArea().append("Average service time is " + this.averageServiceTime + ".\n");
        } catch (IOException var10) {
            var10.printStackTrace();
        }

    }
}
