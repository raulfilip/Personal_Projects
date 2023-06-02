package pachet1;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import pachet3.Server;
import pachet3.Task;

import java.util.List;

public class ConcrreteStrategyTime implements Strategy {
    public ConcrreteStrategyTime() {
    }

    public void addTask(List<Server> servers, Task t) {
        int min1 = Integer.MAX_VALUE;
        int pos = 0;

        for(int i = 0; i < servers.size(); ++i) {
            if (((Server)servers.get(i)).getWaitingPeriod().get() < min1) {
                pos = i;
                min1 = ((Server)servers.get(i)).getWaitingPeriod().get();
            }
        }

        ((Server)servers.get(pos)).addTask(t);
    }
}
