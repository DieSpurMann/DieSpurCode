package org.gameoflife;

import javax.swing.*;
import java.awt.*;

public class ControlPanel extends JPanel implements Observer {
    private GameOfLife game;
    private GameOfLifeUI ui;
    private JButton playBtn;

    public ControlPanel(GameOfLife game, GameOfLifeUI ui, Maine mainapp) {
        this.game = game;
        this.ui = ui;
        this.setLayout(new FlowLayout(FlowLayout.CENTER, 15, 10));
        this.setBackground(new Color(20, 20, 20)); // Fond sombre circuit

        // Bouton PLAY/PAUSE
        playBtn = createStyledButton("START");
        playBtn.addActionListener(e -> game.modifyPause());

        // Bouton NEXT LAP
        JButton nextBtn = createStyledButton("NEXT LAP >");
        nextBtn.addActionListener(e -> {
            if (game.isPaused()) {
                game.executeCommands();
                game.distributeVisitor();
                game.notifyObservers();
            }
        });

        // Slider Vitesse
        JSlider slider = new JSlider(10, 1000, 100);
        slider.setBackground(new Color(20, 20, 20));
        slider.addChangeListener(e -> mainapp.setDelay(slider.getValue()));

        // Sélecteur de Thèmes
        String[] themes = {"Nordschleife", "Soviet", "Chornobyl"};
        JComboBox<String> themeBox = new JComboBox<>(themes);
        themeBox.addActionListener(e -> {
            String selected = (String) themeBox.getSelectedItem();
            if ("Nordschleife".equals(selected)) ui.updateTheme("/nurb.jpg");
            else if ("Soviet".equals(selected)) ui.updateTheme("/soviet-flag.jpg");
            else if ("Chornobyl".equals(selected)) ui.updateTheme("/chornobyl.jpg");
        });

        this.add(playBtn);
        this.add(nextBtn);
        this.add(new JLabel("<html><font color='white'>SPEED:</font></html>"));
        this.add(slider);
        this.add(new JLabel("<html><font color='white'>THEME:</font></html>"));
        this.add(themeBox);
    }

    private JButton createStyledButton(String text) {
        JButton b = new JButton(text);
        b.setBackground(Color.BLACK);
        b.setForeground(Color.GREEN);
        b.setBorder(BorderFactory.createLineBorder(Color.GREEN, 1));
        return b;
    }

    @Override
    public void refresh() {
        playBtn.setText(game.isPaused() ? "START" : "STOP");
        playBtn.setForeground(game.isPaused() ? Color.GREEN : Color.RED);
    }
}