public class TetrominoI extends Tetromino{
    
    public TetrominoI(int row_, int col_, Grid grid_, int rotation_) {
        super(row_, col_, grid_);
        ghost = true;
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, clr);
        blocks[1] = new Block(row, col + 1, clr);
        blocks[2] = new Block(row, col - 1, clr);
        blocks[3] = new Block(row, col - 2, clr);
        
        while(rotation != rotation_)
            rotate(true);
    }
    
    public TetrominoI(int row_, int col_, Grid grid_) {
        super(row_, col_, grid_);
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, clr);
        blocks[1] = new Block(row, col + 1, clr);
        blocks[2] = new Block(row, col - 1, clr);
        blocks[3] = new Block(row, col - 2, clr);
    }
    
    public TetrominoI(Grid grid_) {
        super(1, 5, grid_);
        row = 1;
        col = 5;
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, clr);
        blocks[1] = new Block(row, col + 1, clr);
        blocks[2] = new Block(row, col - 1, clr);
        blocks[3] = new Block(row, col - 2, clr);
    }
    
    public boolean rotate(boolean clockwise) {
        if (clockwise) {
            rotation++;
        } else {
            rotation --;
        }
        if (rotation > 3) {
            rotation = 0;
        }
        if (rotation < 0) {
            rotation = 3;
        }
        
        if (rotation == 0) {
            blocks[0].setPos(row, col);
            blocks[1].setPos(row, col + 1);
            blocks[2].setPos(row, col - 1);
            blocks[3].setPos(row, col - 2);
        } else if (rotation == 1) {
            blocks[0].setPos(row, col);
            blocks[1].setPos(row - 1, col);
            blocks[2].setPos(row + 1, col);
            blocks[3].setPos(row + 2, col);
        } else if (rotation == 2) {
            blocks[0].setPos(row + 1, col);
            blocks[1].setPos(row + 1, col + 1);
            blocks[2].setPos(row + 1, col - 1);
            blocks[3].setPos(row + 1, col - 2);
        } else if (rotation == 3) {
            blocks[0].setPos(row, col - 1);
            blocks[1].setPos(row - 1, col - 1);
            blocks[2].setPos(row + 1, col - 1);
            blocks[3].setPos(row + 2, col - 1);
        }
        
        if (!ghost)
            return moveInBounds(clockwise);
        return false;
    }
    
    public void reset() {
        row = 1;
        col = 5;
        rotation = 0;
        blocks[0].setPos(row, col);
        blocks[1].setPos(row, col + 1);
        blocks[2].setPos(row, col - 1);
        blocks[3].setPos(row, col - 2);
    }
    
    public void displayGhost() {
        Tetromino ghost = new TetrominoI(row, col, grid, rotation);
        ghost.setPos(row, col);
        while(ghost.canMove("down"))
            ghost.move("down");
        ghost.display(70 - (row * 3));
    }
    
    public TetrominoI clone() {
        return new TetrominoI(row, col, grid);
    }
}