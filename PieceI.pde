public class PieceI extends Tetromino{
    
    public PieceI(int row_, int col_, int scale_, Grid grid_, int rotation_){
        super(row_, col_, scale_, grid_);
        ghost = true;
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row, col - 2, scale, clr);

        while(rotation != rotation_)
            rotate(true);
    }

    public PieceI(int row_, int col_, int scale_, Grid grid_){
        super(row_, col_, scale_, grid_);
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row, col - 2, scale, clr);
    }

    public PieceI(int scale_, Grid grid_){
        super(1, 5, scale_, grid_);
        row = 1;
        col = 5;
        color clr = color(0, 255, 255);
        blocks[0] = new Block(row, col, scale, clr);
        blocks[1] = new Block(row, col + 1, scale, clr);
        blocks[2] = new Block(row, col - 1, scale, clr);
        blocks[3] = new Block(row, col - 2, scale, clr);
    }

    public void rotate(boolean clockwise){
        if(clockwise){
            rotation++;
        } else {
            rotation --;
        }
        if(rotation > 3){
            rotation = 0;
        }
        if(rotation < 0){
            rotation = 3;
        }

        if(rotation == 0){
            blocks[0].setPos(row, col);
            blocks[1].setPos(row, col + 1);
            blocks[2].setPos(row, col - 1);
            blocks[3].setPos(row, col - 2);
        } else if(rotation == 1){
            blocks[0].setPos(row, col);
            blocks[1].setPos(row - 1, col);
            blocks[2].setPos(row + 1, col);
            blocks[3].setPos(row + 2, col);
        } else if(rotation == 2){
            blocks[0].setPos(row + 1, col);
            blocks[1].setPos(row + 1, col + 1);
            blocks[2].setPos(row + 1, col - 1);
            blocks[3].setPos(row + 1, col - 2);
        } else if(rotation == 3){
            blocks[0].setPos(row, col - 1);
            blocks[1].setPos(row - 1, col - 1);
            blocks[2].setPos(row + 1, col - 1);
            blocks[3].setPos(row + 2, col - 1);
        } 
        if(!ghost)
            moveInBounds(clockwise);
    }

    public void reset(){
        row = 1;
        col = 5;
        rotation = 0;
        blocks[0].setPos(row, col);
        blocks[1].setPos(row, col + 1);
        blocks[2].setPos(row, col - 1);
        blocks[3].setPos(row, col - 2);
    }

    public void displayGhost(){
        Tetromino ghost = new PieceI(row, col, scale, grid, rotation);
        ghost.setPos(row, col);
        while(ghost.canMove("down"))
            ghost.move("down");
        ghost.display(70 - (row * 3));
    }

    public PieceI clone(){
        return new PieceI(row, col, scale, grid);
    }
}