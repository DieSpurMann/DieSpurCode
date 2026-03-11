package GameOfLife.app.src.main.java.org.gameoflife;

import java.util.*;

public class GameOfLife implements Subject {
    public Cell[][] board;
    private int maxX = 3;
    private int maxY = 3;
    private List<Observer> observers;

    public GameOfLife () {
        this.observers = new ArrayList<>();
        this.board = new Cell[this.maxX][this.maxY];
    }

    public int getXmax() {
        return this.maxX;
    }

    public int getYmax() {
        return this.maxY;
    }

    public void initializeBoard() {
        for (int x = 0; x < this.maxX; x++) {
            for (int y = 0; y < this.maxY; y++) {
                if (Math.random() < 0.5) {
                    this.board[x][y] = new Cell(x, y, AliveCell.getInstance());
                } else {
                    this.board[x][y] = new Cell(x, y, DeadCell.getInstance());
                }
            }
        }
    }

    public Cell getCell(int x, int y) {
        if (x < 0 || x >= this.maxX || y < 0 || y >= this.maxY) {
            return null; // Out of bounds
        }
        return this.board[x][y];
    }

    @Override
    public void removeObserver(Observer observer) {
        observers.remove(observer);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.refresh();
        }
    }

    @Override
    public void registerObserver(Observer observer) {
        observers.add(observer);
    }
}
