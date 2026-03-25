package org.gameoflife;

public class ClassicVisitor extends Visitor {

    public ClassicVisitor(GameOfLife game) {
        super(game);
    }

    @Override
    public void visitAliveCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);
        // Une cellule vivante meurt si elle a moins de 2 ou plus de 3 voisines
        if (neighbors < 2 || neighbors > 3) {
            game.addCommands(new DeathCommand(cell));
        }
    }

    @Override
    public void visitDeadCell(Cell cell) {
        int neighbors = cell.getNumberOfAliveNeighbours(game);
        // Une cellule morte ressuscite si elle a exactement 3 voisines
        if (neighbors == 3) {
            game.addCommands(new LiveCommand(cell));
        }
    }
}