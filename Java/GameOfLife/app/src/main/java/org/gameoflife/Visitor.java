package org.gameoflife;

public abstract class Visitor {
    protected GameOfLife game;

    public Visitor(GameOfLife game) {
        this.game = game;
    }

    public abstract void visitAliveCell(Cell cell);
    public abstract void visitDeadCell(Cell cell);
}