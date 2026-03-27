package org.gameoflife;

import java.util.*;

public class GameOfLife implements Subject {
    public Cell[][] board;
    private int maxX = 1000;
    private int maxY = 1000;
    private List<Observer> observers;
    private List<Command> commands;
    private Visitor visitor;
    private boolean pause;

    public GameOfLife () {
        this.observers = new ArrayList<>();
        this.commands = new ArrayList<>();
        this.board = new Cell[this.maxX][this.maxY];
        this.visitor = new ClassicVisitor(this);
        this.pause = false;
        this.initializeBoard();
    }

    public int getXmax() {
        return this.maxX;
    }

    public int getYmax() {
        return this.maxY;
    }

    public boolean isPaused() {
        return this.pause;
    }

    public void addCommands(Command command) {
        commands.add(command);
    }

    public void executeCommands() {
        for(Command c: commands) {
            c.execute();
        }
        commands.clear();
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

    public void modifyPause() {
        this.pause = !this.pause;
        System.out.println(this.pause);
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

    public void distributeVisitor() {
        for (int x = 0; x < this.maxX; x++) {
            for (int y = 0; y < this.maxY; y++) {
                this.board[x][y].accept(this.visitor);
            }
        }
    }

    public void calculateNextGeneration() {
        if (!this.pause) {
            executeCommands();
            distributeVisitor();
            notifyObservers();
        }
    }
}
