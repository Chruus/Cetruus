import java.util.*;

public class Bag{
    ArrayList<Tetromino> main, reserve;
    Grid grid;
    int scale;
    
    public Bag(int scale_, Grid grid_) {
        scale = scale_;
        grid = grid_;
        main = new ArrayList<Tetromino>();
        reserve = new ArrayList<Tetromino>();
        reset(main);
        reset(reserve);
    }
    
    public Tetromino getNextTetromino() {
        if (main.size() == 0) {
            for (Tetromino tetro : reserve)
                main.add(tetro);
            reset(reserve);
        }
        
        main.get(0).reset();
        return main.remove(0);
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
        bag.add(new TetrominoI(scale, grid));
        bag.add(new TetrominoJ(scale, grid));
        bag.add(new TetrominoL(scale, grid));
        bag.add(new TetrominoO(scale, grid));
        bag.add(new TetrominoS(scale, grid));
        bag.add(new TetrominoT(scale, grid));
        bag.add(new TetrominoZ(scale, grid));
        Collections.shuffle(bag);
    }
}