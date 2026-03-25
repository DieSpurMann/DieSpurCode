package org.gameoflife;

public class LiveCommand extends Command {

    LiveCommand(Cell c) {
        this.cell = c;
    }

    @Override
    public void execute() {
        this.cell.alive();
    } 
}
