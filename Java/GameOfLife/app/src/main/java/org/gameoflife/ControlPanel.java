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
        this.setBackground(new Color(20, 20, 20));

        playBtn = createStyledButton("START");
        playBtn.addActionListener(e -> game.modifyPause());

        JButton nextBtn = createStyledButton("NEXT LAP >");
        nextBtn.addActionListener(e -> {
            if (game.isPaused()) {
                game.executeCommands();
                game.distributeVisitor();
                game.notifyObservers();
            }
        });

        JButton resetButton = new JButton("RESET");        
        resetButton.addActionListener(e -> {
            game.resetBoard(); 
        });

        JSlider slider = new JSlider(10, 1000, 100);
        slider.setBackground(new Color(20, 20, 20));
        slider.addChangeListener(e -> mainapp.setDelay(slider.getValue()));

        String[] themes = {"Classic", "Nordschleife", "Soviet", "Irradiated Soviet"};
        JComboBox<String> themeBox = new JComboBox<>(themes);
        themeBox.addActionListener(e -> {
            String selected = (String) themeBox.getSelectedItem();
            if ("Classic".equals(selected)) {
                ui.updateTheme(null);
                ui.setCellColor(Color.decode("#20202E"));
                ui.setBGColor(Color.decode("#FAFAFA"));
            } else if ("Nordschleife".equals(selected)) {
                ui.updateTheme("/nurb.jpg");
                ui.setCellColor(Color.decode("#DC3700"));
            } else if ("Soviet".equals(selected)) {
                ui.updateTheme("/soviet-flag.jpg");
                ui.setCellColor(Color.YELLOW);
            } else if ("Irradiated Soviet".equals(selected)) {
                ui.updateTheme("/chornobyl.jpg");
                ui.setCellColor(new Color(173, 255, 47));
            }
        });

        String[] rulesOptions = {"Classic", "High Life", "Day & Night"}; 
        JComboBox<String> rulesSelector = new JComboBox<>(rulesOptions);
        
        rulesSelector.addActionListener(e -> {
            String selectedRule = (String) rulesSelector.getSelectedItem();
            if ("Classic".equals(selectedRule)) {
                game.setVisitor(new ClassicVisitor(game));
                System.out.println("Mode: Classic");
            } else if ("High Life".equals(selectedRule)) {
                game.setVisitor(new HighLifeVisitor(game));
                System.out.println("Mode : HighLife");
            } else if ("Day & Night".equals(selectedRule)) {
                game.setVisitor(new DayNightVisitor(game));
                System.out.println("Mode : Day & Night");
            }
        });

        this.add(playBtn);
        this.add(nextBtn);
        this.add(resetButton);
        this.add(new JLabel("<html><font color='white'>SPEED:</font></html>"));
        this.add(slider);
        this.add(new JLabel("<html><font color='white'>THEME:</font></html>"));
        this.add(themeBox);
        this.add(new JLabel("<html><font color='white'>RULES:</font></html>"));
        this.add(rulesSelector);
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