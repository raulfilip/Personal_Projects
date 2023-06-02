package org.example;

public class Main {
    public Main() {
    }

    public static void main(String[] args) {
        SimulationFrame frame = new SimulationFrame();
        new Controller(frame);
    }
}
