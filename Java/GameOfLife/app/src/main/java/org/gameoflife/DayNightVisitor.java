package org.gameoflife;

public class DayNightVisitor extends Visitor {

    public DayNightVisitor(GameOfLife game) {
        super(game);
    }

    @Override
    public void visitAliveCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);
        
        if (neighbors == 0 || neighbors == 1 || neighbors == 2 || neighbors == 5) {
            game.addCommands(new DeathCommand(cell));
        }
    }

    @Override
    public void visitDeadCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);
        
        if (neighbors == 3 || neighbors == 4 ||neighbors == 6 || neighbors == 7 || neighbors == 8) {
            game.addCommands(new LiveCommand(cell));
        }
    }
}