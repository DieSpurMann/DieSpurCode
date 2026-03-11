package GameOfLife.app.src.main.java.org.gameoflife;

public interface CellState {
    CellState alive();
    CellState dead();
    boolean isAlive();
}
