package org.gameoflife;

public abstract class Command {
    protected Cell cell;
    public abstract void execute();
    
}
