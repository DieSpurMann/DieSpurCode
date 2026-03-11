package GameOfLife.app.src.main.java.org.gameoflife;

import java.awt.Graphics;
import javax.swing.JPanel;

public class GameOfLifeUI extends JPanel implements Observer {
    private GameOfLife game;

    public GameOfLifeUI(GameOfLife game) {
        this.game = game;
        game.registerObserver(this);
    }

    @Override
    public void refresh() {
        repaint();
    }

    public void paint(Graphics g) {
        super.paint(g);
        for (int x = 0; x < game.getXmax(); x++) {
            for (int y = 0; y < game.getYmax(); y++) {
                if (game.getCell(x, y).isAlive()) {
                    g.fillOval(x * 3, y * 3, 3, 3);
                }
            }
        }
    }

    
}