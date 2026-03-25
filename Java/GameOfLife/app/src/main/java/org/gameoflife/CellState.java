package org.gameoflife;

public interface CellState {
    CellState alive();
    CellState dead();
    boolean isAlive();
    void accept(Visitor visitor, Cell cell);
}
