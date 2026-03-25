package org.gameoflife;

import java.awt.Color;

import javax.swing.JFrame;

public class Maine {
    public static void main(String[] args) {
        // 1. Instancier le modèle (le Sujet Observable)
        GameOfLife jeu = new GameOfLife(); 

        // 2. Instancier la vue (l'Observateur) en lui passant le jeu
        GameOfLifeUI gui = new GameOfLifeUI(jeu);
        LogObserver logs = new LogObserver(jeu);
        jeu.initializeBoard(); // Initialiser le jeu avec une configuration de départ

        // 3. Enregistrer l'UI comme observateur du jeu
        jeu.registerObserver(gui);
        jeu.registerObserver(logs);

        // 4. Créer une fenêtre pour afficher l'interface
        JFrame frame = new JFrame("Our Game Of Life");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(gui); // Ajoute ton JPanel à la fenêtre
        frame.setSize(500, 500);
        frame.setVisible(true);
        frame.setBackground(Color.BLACK);

        // 5. TEST : Simuler une évolution pour voir si l'UI réagit
        // Dans une vraie boucle de jeu, tu appellerais une méthode du modèle
        // qui elle-même appelle notifieObservateurs()
        System.out.println("Lancement de la simulation...");
        
       while(true) {
            jeu.calculateNextGeneration(); 
        }
    }
}
