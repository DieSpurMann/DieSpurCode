package org.gameoflife;

import java.awt.BorderLayout;

import javax.swing.JFrame;

public class Maine {
    private int delay = 100;
    public void setDelay(int d) { this.delay = d; }

    public void start() {
        GameOfLife jeu = new GameOfLife();
        GameOfLifeUI gui = new GameOfLifeUI(jeu);
        LogObserver logs = new LogObserver(jeu);
        
        ControlPanel controls = new ControlPanel(jeu, gui, this);

        jeu.registerObserver(gui);
        jeu.registerObserver(logs);
        jeu.registerObserver(controls);

        JFrame frame = new JFrame("Game of Life but it's the Grune Holle");
        frame.setLayout(new BorderLayout());
        
        frame.add(controls, BorderLayout.NORTH);
        frame.add(gui, BorderLayout.CENTER);    

        frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        while(true) {
            jeu.calculateNextGeneration();
            try { Thread.sleep(delay); } catch (InterruptedException e) {}
        }
    }

    public static void main(String[] args) {
        new Maine().start();
    }
}
