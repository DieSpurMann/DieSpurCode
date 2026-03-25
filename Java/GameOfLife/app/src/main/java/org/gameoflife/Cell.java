package org.gameoflife;

public class Cell {
    private CellState state;
    private int x;
    private int y;

    public Cell(int x, int y, CellState state) {
        this.x = x;
        this.y = y;
        this.state = state;
    }

    public Cell(CellState state) {
        this.state = state;
    }

    public CellState getState() {
        return state;
    }

    public boolean isAlive() {
        return state.isAlive();
    }

    public void alive() {
        state = state.alive();
    }

    public void dead() {
        state = state.dead();
    }

    public void accept(Visitor visitor) {
        state.accept(visitor, this);
    }

    public int getNumberOfAliveNeighbours(GameOfLife game) {
        int aliveNeighbours = 0;
        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                if (i == 0 && j == 0) continue; // Skip the cell itself
                Cell neighbour = game.getCell(x + i, y + j);
                if (neighbour != null && neighbour.isAlive()) {
                    aliveNeighbours++;
                }
            }
        }
        return aliveNeighbours;
    } 
}
