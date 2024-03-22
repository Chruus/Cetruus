public class TetrominoJ extends Tetromino{
    
    public TetrominoJ(int row_, int col_, int scale_, Grid grid_, int rotation_) {
        super(row_, col_, scale_, grid_);
        ghost = true;
        color clr = color(50, 50, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row - 1, col - 1, scale, clr);
        
        while(rotation != rotation_)
            rotate(true);
    }
    
    public TetrominoJ(int row_, int col_, int scale_, Grid grid_) {
        super(row_, col_, scale_, grid_);
        color clr = color(50, 50, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row - 1, col - 1, scale, clr);
    }
    
    public TetrominoJ(int scale_, Grid grid_) {
        super(1, 4, scale_, grid_);
        row = 1;
        col = 4;
        color clr = color(25, 25, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row - 1, col - 1, scale, clr);
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
            blocks[3].setPos(row - 1, col - 1);
        } else if (rotation == 1) {
            blocks[0].setPos(row, col);
            blocks[1].setPos(row + 1, col);
            blocks[2].setPos(row - 1, col);
            blocks[3].setPos(row - 1, col + 1);
        } else if (rotation == 2) {
            blocks[0].setPos(row, col);
            blocks[1].setPos(row, col - 1);
            blocks[2].setPos(row, col + 1);
            blocks[3].setPos(row + 1, col + 1);
        } else if (rotation == 3) {
            blocks[0].setPos(row, col);
            blocks[1].setPos(row - 1, col);
            blocks[2].setPos(row + 1, col);
            blocks[3].setPos(row + 1, col - 1);
        }
        
        if (!ghost)
            return moveInBounds(clockwise);
        return false;
    }
    
    public void reset() {
        row = 1;
        col = 4;
        rotation = 0;
        blocks[0].setPos(row, col);
        blocks[1].setPos(row, col + 1);
        blocks[2].setPos(row, col - 1);
        blocks[3].setPos(row - 1, col - 1);
    }
    
    public void displayGhost() {
        Tetromino ghost = new TetrominoJ(row, col, scale, grid, rotation);
        ghost.setPos(row, col);
        while(ghost.canMove("down"))
            ghost.move("down");
        ghost.display(70 - (row * 3));
    }
    
    public TetrominoJ clone() {
        return new TetrominoJ(row, col, scale, grid);
    }
}