package org.gameoflife;

import javax.swing.*;
import java.awt.*;

public class ControlPanel extends JPanel implements Observer {
    private GameOfLife game;
    private JButton playBtn;

    public ControlPanel(GameOfLife game, Maine mainApp) {
        this.game = game;
        this.setLayout(new FlowLayout());

        // Bouton Play/Pause
        playBtn = new JButton("Play");
        playBtn.addActionListener(e -> game.modifyPause());

        // Bouton Suivant
        JButton nextBtn = new JButton("Suivant >");
        nextBtn.addActionListener(e -> {
            if (game.isPaused()) {
                game.executeCommands();
                game.distributeVisitor();
                game.notifyObservers();
            }
        });

        // Slider Vitesse
        JSlider slider = new JSlider(10, 1000, 100);
        slider.addChangeListener(e -> mainApp.setDelay(slider.getValue()));

        this.add(playBtn);
        this.add(nextBtn);
        this.add(new JLabel(" Vitesse (ms):"));
        this.add(slider);

        String[] themes = {"Nordschleife", "Soviet", "Chornobyl"};
        JComboBox<String> combo = new JComboBox<>(themes);
            
        combo.addActionListener(e -> {
            String selected = (String) combo.getSelectedItem();
            if (selected.equals("Nordschleife")) {
                ui.updateTheme("/nurb.jpg"); // Ton fichier Nordschleife
            } else if (selected.equals("Soviet")) {
                ui.updateTheme("/soviet-flag.jpg"); // Ton fichier Soviet
            } else if (selected.equals("Chornobyl")) {
                ui.updateTheme("/chornobyl.jpg"); // Ton fichier Chornobyl
            }
        });
        
        this.add(new JLabel("THÈME :"));
        this.add(combo);
    }

    @Override
    public void refresh() {
        // On change le texte du bouton selon l'état du jeu
        playBtn.setText(game.isPaused() ? "Play" : "Pause");
    }
}