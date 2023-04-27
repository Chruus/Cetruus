import java.util.*;

public class Bag{
    ArrayList<Tetromino> main, reserve;
    Grid grid;
    int scale;

    public Bag(int scale_, Grid grid_){
        scale = scale_;
        grid = grid_;
        main = new ArrayList<Tetromino>();
        reserve = new ArrayList<Tetromino>();
        reset(main);
        reset(reserve);
    }

    public Tetromino getNextPiece(){
        if(main.size() == 0){
            for(Tetromino piece : reserve)
                main.add(piece);
            reset(reserve);
        }

        main.get(0).reset();
        return main.remove(0);
    }

    public ArrayList<Tetromino> getFuturePieces(){
        ArrayList<Tetromino> futurePieces = new ArrayList<Tetromino>();
        for(Tetromino piece : main){
            if(futurePieces.size() >= 3)
                break;
            futurePieces.add(piece);
        }
        for(Tetromino piece : reserve){
            if(futurePieces.size() >= 3)
                break;
            futurePieces.add(piece);
        }
        return futurePieces;
    }

    private void reset(ArrayList<Tetromino> bag){
        bag.clear();
        bag.add(new PieceI(scale, grid));
        bag.add(new PieceJ(scale, grid));
        bag.add(new PieceL(scale, grid));
        bag.add(new PieceO(scale, grid));
        bag.add(new PieceS(scale, grid));
        bag.add(new PieceT(scale, grid));
        bag.add(new PieceZ(scale, grid));
        Collections.shuffle(bag);
    }
}