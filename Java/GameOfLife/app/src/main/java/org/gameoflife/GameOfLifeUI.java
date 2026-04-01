package org.gameoflife;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.awt.geom.AffineTransform;
import java.awt.geom.NoninvertibleTransformException;
import java.awt.geom.Point2D;
import javax.swing.AbstractAction;
import javax.swing.ActionMap;
import javax.swing.ImageIcon;
import javax.swing.InputMap;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.KeyStroke;

public class GameOfLifeUI extends JPanel implements Observer, MouseWheelListener, MouseMotionListener, MouseListener {
    private GameOfLife game;
    private Image backgroundImage;

    private double zoom = 3.0;
    private double panX = 0.0;
    private double panY = 0.0;
    private Point lastMouse;
    private Color cellColor = Color.decode("#20202E");
    private Color bgColor = Color.decode("#AAAAAA");

    public GameOfLifeUI(GameOfLife game) {
        this.game = game;
        game.registerObserver(this);
        this.setCellColor(Color.decode("#20202E"));
        this.setBGColor(Color.decode("#FAFAFA"));
        this.addMouseWheelListener(this);
        this.addMouseMotionListener(this);
        this.addMouseListener(this);
        InputMap im = this.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW);
        ActionMap am = this.getActionMap();

        im.put(KeyStroke.getKeyStroke("SPACE"), "pauseAction");

        am.put("pauseAction", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                toggleSimulation();
            }
        });
    }

    public void updateTheme(String path) {
        if (path == null) {
            this.backgroundImage = null;
            repaint();
            return;
        }

        ImageIcon icon = new ImageIcon(getClass().getResource(path));
        if (icon.getImageLoadStatus() == MediaTracker.COMPLETE) {
            this.backgroundImage = icon.getImage();
            repaint();
        }
    }

    public void setCellColor(Color newColor) {
        this.cellColor = newColor;
        repaint();
    }

    public void setBGColor(Color newColor) {
        this.bgColor = newColor;
        repaint();
    }

    @Override
    public void refresh() {
        repaint();
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        Graphics2D g2 = (Graphics2D) g.create(); 
        if (backgroundImage != null) {
            g2.drawImage(backgroundImage, 0, 0, getWidth(), getHeight(), this);
        } else {
            g2.setColor(this.bgColor); 
            g2.fillRect(0, 0, getWidth(), getHeight());
        }

        AffineTransform camera = new AffineTransform();
        camera.translate(panX, panY); 
        camera.scale(zoom, zoom);     
        g2.transform(camera);
        try {
            AffineTransform inverse = camera.createInverse();
            Point2D.Double topLeft = new Point2D.Double(0, 0);
            Point2D.Double bottomRight = new Point2D.Double(getWidth(), getHeight());
            
            inverse.transform(topLeft, topLeft);
            inverse.transform(bottomRight, bottomRight);

            int startX = Math.max(0, (int) Math.floor(topLeft.x));
            int startY = Math.max(0, (int) Math.floor(topLeft.y));
            int endX = Math.min(game.getXmax(), (int) Math.ceil(bottomRight.x));
            int endY = Math.min(game.getYmax(), (int) Math.ceil(bottomRight.y));

            g2.setColor(this.cellColor);
            g2.setBackground(this.bgColor);
            
            for (int x = startX; x < endX; x++) {
                for (int y = startY; y < endY; y++) {
                    Cell cell = game.getCell(x, y);
                    if (cell != null && cell.isAlive()) {
                        g2.fillRect(x, y, 1, 1);
                    }
                }
            }
        } catch (NoninvertibleTransformException e) {
            e.printStackTrace();
        }

        g2.dispose();
    }

    private void toggleSimulation() {
        System.out.println("Touche Espace pressée : Pause/Lecture");
        this.game.modifyPause(); 
    }

    @Override
    public void mouseWheelMoved(MouseWheelEvent e) {
        double oldZoom = zoom;
        if (e.getWheelRotation() < 0) {
            zoom *= 1.1;
        } else {
            zoom /= 1.1;
        }
        zoom = Math.max(0.1, Math.min(zoom, 100.0));

        double scaleChange = zoom / oldZoom;
        panX = e.getX() - scaleChange * (e.getX() - panX);
        panY = e.getY() - scaleChange * (e.getY() - panY);

        repaint();
    }

    @Override
    public void mousePressed(MouseEvent e) {
        lastMouse = e.getPoint();
    }

    @Override
    public void mouseDragged(MouseEvent e) {
        if (lastMouse != null) {
            panX += e.getX() - lastMouse.x;
            panY += e.getY() - lastMouse.y;
            lastMouse = e.getPoint();
            repaint();
        }
    }

    @Override public void mouseReleased(MouseEvent e) { lastMouse = null; }
    @Override public void mouseMoved(MouseEvent e) {}
    @Override public void mouseClicked(MouseEvent e) {}
    @Override public void mouseEntered(MouseEvent e) {}
    @Override public void mouseExited(MouseEvent e) {}
}