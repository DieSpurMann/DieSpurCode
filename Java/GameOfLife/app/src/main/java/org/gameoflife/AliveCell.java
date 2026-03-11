package GameOfLife.app.src.main.java.org.gameoflife;

public class AliveCell implements CellState {
    private static AliveCell instance = new AliveCell();

    public AliveCell() {}

    public CellState alive() {
        return instance;
    }

    public CellState dead() {
        return DeadCell.getInstance();
    }
    
    public boolean isAlive() {
        return true;
    }

    public static AliveCell getInstance() {
        return instance;
    }
    
}
