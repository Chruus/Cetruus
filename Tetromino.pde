public abstract class Tetromino{
    int row, col;
    Block[] blocks;
    Block[][] grid;
    int rotation, scale;
    boolean ghost;

    public Tetromino(int row_, int col_, int scale_, Block[][] grid_){
        row = row_;
        col = col_;
        scale = scale_;
        grid = grid_;
        blocks = new Block[4];
        rotation = 0;
        ghost = false;
    }


    public void display(){
        for(Block block : blocks){
            block.display();
        }
    }

    public void display(int opacity){
        for(Block block : blocks){
            block.display(opacity);
        }
    }

    public void moveDown(){
        row++;
        for(Block block : blocks){
            block.setPos(block.row() + 1, block.col());
        }
    }

    public void hardDrop(){
        while(canMove("down")){
            moveDown();
        }
        addToGrid();
    }

    public void addToGrid(){
        for(Block block : blocks){
            grid[block.row()][block.col()] = block.clone();
        }
    }

    public void setPos(int newRow, int newCol){
        while(row < newRow){
            move("down");
        }
        while(row > newRow){
            move("up");
        }
        while(col < newCol){
            move("right");
        }
        while(col > newCol){
            move("left");
        }
    }

    public void move(String direction){
        if(direction.equals("right")){
            col++;
            for(Block block : blocks){
                block.setPos(block.row(), block.col() + 1);
            }
        } else if(direction.equals("left")){
            col--;
            for(Block block : blocks){
                block.setPos(block.row(), block.col() - 1);
            }
        } else if(direction.equals("up")){
            row--;
            for(Block block : blocks){
                block.setPos(block.row() - 1, block.col());
            }
        } else if(direction.equals("down")){
            row++;
            for(Block block : blocks){
                block.setPos(block.row() + 1, block.col());
            }
        }
    }

    public boolean canMove(String direction){
        for(Block block : blocks){
            if((direction.equals("right") && (block.col() >= grid[0].length - 1 || grid[block.row()][block.col() + 1] != null))
            || (direction.equals("left") && (block.col() <= 0 || grid[block.row()][block.col() - 1] != null))
            || (direction.equals("up") && (block.row() <= 0 || grid[block.row() - 1][block.col()] != null))
            || (direction.equals("down") && (block.row() >= grid.length - 1 || grid[block.row() + 1][block.col()] != null))){
                return false;
            }
        }
        return true;
    }

    public void moveInBounds(boolean clockwise){
        for(Block block : blocks){
            while(block.row() < 0 && canMove("down"))
                move("down");
            while(block.row() >= grid.length && canMove("up"))
                move("up");
            while(block.col() < 0 && canMove("right"))
                move("right");
            while(block.col() >= grid[0].length && canMove("left"))
                move("left");
        }
        if(!isInBounds())
                rotate(!clockwise);
    }

    public boolean isInBounds(){
        for(Block block : blocks){
            if(block.row() < 0 || block.col() < 0 || block.row() >= grid.length 
            || block.col() >= grid[0].length || grid[block.row()][block.col()] != null)
                return false;
        }
        return true;
    }

    public abstract Tetromino clone();

    public abstract void rotate(boolean clockwise);

    public abstract void reset();

    public abstract void displayGhost();
}