package pachet1;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import pachet3.Server;
import pachet3.Task;

import java.util.List;

public class ConcreteStrategyQueue implements Strategy {
    public ConcreteStrategyQueue() {
    }

    public void addTask(List<Server> servers, Task t) {
        int min1 = Integer.MAX_VALUE;
        int pos = 0;

        for(int i = 0; i < servers.size(); ++i) {
            if (min1 > ((Server)servers.get(i)).getTasks().size()) {
                pos = i;
                min1 = ((Server)servers.get(i)).getTasks().size();
            }
        }

        ((Server)servers.get(pos)).addTask(t);
    }
}
