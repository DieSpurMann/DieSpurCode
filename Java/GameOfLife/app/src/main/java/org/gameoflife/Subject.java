package GameOfLife.app.src.main.java.org.gameoflife;

public interface Subject {
    void registerObserver(Observer observer);
    void removeObserver(Observer observer);
    void notifyObservers();
}
