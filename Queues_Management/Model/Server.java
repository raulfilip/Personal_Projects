package pachet3;//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import pachet2.SimulationManager;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;

public class Server implements Runnable {
    private BlockingQueue<Task> tasks;
    private AtomicInteger waitingPeriod;

    public Server(int maxTasksPerServer) {
        this.tasks = new ArrayBlockingQueue(maxTasksPerServer);
        this.waitingPeriod = new AtomicInteger();
    }

    public void deleteTask() {
        for(int i = 0; i < this.tasks.size(); ++i) {
            if (((Task)this.tasks.peek()).getServiceTime() == 0) {
                this.tasks.remove();
            }
        }

    }

    public void addTask(Task newTask) {
        this.tasks.add(newTask);
        this.waitingPeriod.addAndGet(newTask.getServiceTime());
    }

    public void run() {
        new Task(0, 0);

        while(SimulationManager.runVariable) {
            if (!this.tasks.isEmpty()) {
                Task t = (Task)this.tasks.peek();
                if (t != null) {
                    try {
                        Thread.sleep((long)(t.getServiceTime() * 1000));
                    } catch (InterruptedException var3) {
                        var3.printStackTrace();
                    }
                }

                this.waitingPeriod.addAndGet(-t.getServiceTime());
            }
        }

    }

    public BlockingQueue<Task> getTasks() {
        return this.tasks;
    }

    public AtomicInteger getWaitingPeriod() {
        return this.waitingPeriod;
    }
}
