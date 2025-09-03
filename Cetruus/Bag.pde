import java.util.*;

public class Bag{
    ArrayList<Tetromino> main, reserve;
    Grid grid;
    
    public Bag(Grid grid_) {
        grid = grid_;
        main = new ArrayList<Tetromino>();
        reserve = new ArrayList<Tetromino>();
        reset(main);
        reset(reserve);
    }
    
    public Tetromino getNextTetromino() {
        if (main.size() == 0) {
            reserveToMain();
        }
        
        main.get(0).reset();
        return main.remove(0);
    }
    
    public void reserveToMain() {
        for (Tetromino tetro : reserve)
            main.add(tetro);
        reset(reserve);
    }
    
    public ArrayList<Tetromino> getFutureTetrominos() {
        ArrayList<Tetromino> futureTetros = new ArrayList<Tetromino>();
        for (Tetromino tetro : main) {
            if (futureTetros.size() >= 3)
                break;
            futureTetros.add(tetro);
        }
        for (Tetromino tetro : reserve) {
            if (futureTetros.size() >= 3)
                break;
            futureTetros.add(tetro);
        }
        return futureTetros;
    }
    
    private void reset(ArrayList<Tetromino> bag) {
        bag.clear();
        bag.add(new TetrominoI(grid));
        bag.add(new TetrominoJ(grid));
        bag.add(new TetrominoL(grid));
        bag.add(new TetrominoO(grid));
        bag.add(new TetrominoS(grid));
        bag.add(new TetrominoT(grid));
        bag.add(new TetrominoZ(grid));
        Collections.shuffle(bag);
    }
    
    public String toString() {
        return main.toString();
    }
}