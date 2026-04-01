package org.gameoflife;

public class HighLifeVisitor extends Visitor {

    public HighLifeVisitor(GameOfLife game) {
        super(game);
    }

    @Override
    public void visitAliveCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);
        if (neighbors < 2 || neighbors > 3) {
            game.addCommands(new DeathCommand(cell));
        }
    }

    @Override
    public void visitDeadCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);        
        if (neighbors == 3 || neighbors == 6) {
            game.addCommands(new LiveCommand(cell));
        }
    }
}