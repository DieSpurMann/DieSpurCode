package GameOfLife.app.src.main.java.org.gameoflife;

public class DeadCell implements CellState {

    private static DeadCell instance = new DeadCell();

    public DeadCell() {}

    public CellState alive() {
        return AliveCell.getInstance();
    }

    public CellState dead() {
        return instance;
    }

    public boolean isAlive() {
        return false;
    }

    public static DeadCell getInstance() {
        return instance;
    }
}
