package org.gameoflife;

public class LogObserver implements Observer {
    private GameOfLife game;
    private int generation;

    public LogObserver(GameOfLife game) {
        this.game = game;
        this.generation = 0;
    }

    @Override
    public void refresh() {
        this.generation++;
        int aliveCount = 0;

        for (int x = 0; x < game.getXmax(); x++) {
            for (int y = 0; y < game.getYmax(); y++) {
                Cell cell = game.getCell(x, y);
                if (cell != null && cell.isAlive()) {
                    aliveCount++;
                }
            }
        }

        System.out.println("Gen number " + generation + " | Comrades alive : " + aliveCount);
    }
}