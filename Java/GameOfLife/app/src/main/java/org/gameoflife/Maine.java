package org.gameoflife;

import java.awt.BorderLayout;

import javax.swing.JFrame;

// Dans Maine.java
public class Maine {
    private int delay = 100;
    public void setDelay(int d) { this.delay = d; }

    public void start() {
        GameOfLife jeu = new GameOfLife();
        GameOfLifeUI gui = new GameOfLifeUI(jeu);
        LogObserver logs = new LogObserver(jeu);
        
        // On crée notre nouveau panneau de contrôle
        ControlPanel controls = new ControlPanel(jeu, gui, this);

        // On enregistre les DEUX comme observateurs
        jeu.registerObserver(gui);
        jeu.registerObserver(logs);
        jeu.registerObserver(controls);

        JFrame frame = new JFrame("Game of Life but it's the Grune Holle");
        frame.setLayout(new BorderLayout());
        
        // On les place dans la fenêtre
        frame.add(controls, BorderLayout.NORTH); // Les boutons en haut
        frame.add(gui, BorderLayout.CENTER);      // La grille au milieu

        frame.setSize(800, 600);
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
