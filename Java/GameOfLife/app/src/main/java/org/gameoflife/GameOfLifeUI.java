package org.gameoflife;

import java.awt.*;
import java.awt.event.*;
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

    // Variables de navigation (beaucoup plus simples !)
    private double zoom = 3.0;
    private double panX = 0.0;
    private double panY = 0.0;
    private Point lastMouse;

    public GameOfLifeUI(GameOfLife game) {
        this.game = game;
        game.registerObserver(this);
        
        ImageIcon icon = new ImageIcon(getClass().getResource("/nurb.jpg"));
        if (icon.getImageLoadStatus() == MediaTracker.COMPLETE) {
            this.backgroundImage = icon.getImage();
        }
        this.setBackground(Color.decode("#FF3212"));

        this.addMouseWheelListener(this);
        this.addMouseMotionListener(this);
        this.addMouseListener(this);
        // On récupère l'InputMap du composant principal (par exemple le JPanel de la grille)
        InputMap im = this.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW);
        ActionMap am = this.getActionMap();

        // On lie la touche "SPACE" à un identifiant textuel
        im.put(KeyStroke.getKeyStroke("SPACE"), "pauseAction");

        // On définit l'action correspondant à cet identifiant
        am.put("pauseAction", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                toggleSimulation();
            }
        });
    }

    
    @Override
    public void refresh() {
        repaint();
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        Graphics2D g2 = (Graphics2D) g.create(); // On crée une copie pour ne pas altérer le Graphics original

        // 1. Dessin du fond d'écran (fixe)
        if (backgroundImage != null) {
            g2.drawImage(backgroundImage, 0, 0, getWidth(), getHeight(), this);
        } else {
            g2.setColor(new Color(50, 0, 0));
            g2.fillRect(0, 0, getWidth(), getHeight());
        }

        // 2. Création de la "Caméra" virtuelle
        AffineTransform camera = new AffineTransform();
        camera.translate(panX, panY); // Déplacement
        camera.scale(zoom, zoom);     // Zoom
        g2.transform(camera);         // Application de la caméra au pinceau

        // 3. Dessin ultra-rapide des cellules
        // On demande à Java de nous donner les coordonnées de l'écran converties dans le monde du jeu
        // pour ne dessiner QUE ce qui est visible à l'écran.
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

            g2.setColor(Color.decode("#dc3700"));
            
            // On dessine directement avec les vraies coordonnées (1x1), le moteur graphique gère le zoom tout seul !
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

        g2.dispose(); // Libération des ressources graphiques
    }

    private void toggleSimulation() {
        System.out.println("Touche Espace pressée : Pause/Lecture");
        this.game.modifyPause(); 
    }

    @Override
    public void mouseWheelMoved(MouseWheelEvent e) {
        double oldZoom = zoom;
        if (e.getWheelRotation() < 0) {
            zoom *= 1.1; // Zoom in
        } else {
            zoom /= 1.1; // Zoom out
        }
        // Limites du zoom
        zoom = Math.max(0.1, Math.min(zoom, 100.0));

        // Mathématiques pour zoomer vers le pointeur de la souris (et non vers le coin en haut à gauche)
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