package pachet3;//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

public class Task implements Comparable {
    private int arrivalTime;
    private int serviceTime;
    private int ID;
    private static int nr = 0;

    public Task(int arrivalTime, int serviceTime) {
        this.arrivalTime = arrivalTime;
        this.serviceTime = serviceTime;
        ++nr;
        this.ID = nr;
    }

    public int getArrivalTime() {
        return this.arrivalTime;
    }

    public int getServiceTime() {
        return this.serviceTime;
    }

    public void setServiceTime(int serviceTime) {
        this.serviceTime = serviceTime;
    }

    public int compareTo(Object o) {
        Task t = (Task)o;
        return t.getArrivalTime() > this.arrivalTime ? -1 : 1;
    }

    public String toString() {
        return "(" + this.ID + " " + this.arrivalTime + " " + this.serviceTime + ")";
    }
}
