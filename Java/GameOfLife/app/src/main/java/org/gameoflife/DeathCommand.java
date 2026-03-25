package org.gameoflife;

public class DeathCommand extends Command {

    DeathCommand(Cell c) {
        this.cell = c;
    }

    @Override
    public void execute() {
        this.cell.dead();
    } 
}
