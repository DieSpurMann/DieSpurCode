package GameOfLife.app.src.main.java.org.gameoflife;

public class Command {
    private Cell cell;

    void execute() {
        if (cell.isAlive()) {
            cell.dead();
        } else {
            cell.alive();
        }
    }
    
}
