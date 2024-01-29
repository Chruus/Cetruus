public abstract class Tetromino{
    Block[] blocks;
    boolean ghost;
    Grid grid;
    int row, col;
    int rotation, scale;
    
    public Tetromino(int row_, int col_, int scale_, Grid grid_) {
        row = row_;
        col = col_;
        scale = scale_;
        grid = grid_;
        blocks = new Block[4];
        rotation = 0;
        ghost = false;
    }
    
    
    public void display() {
        for (Block block : blocks) {
            block.display();
        }
    }
    
    public void display(int opacity) {
        for (Block block : blocks) {
            block.display(opacity);
        }
    }
    
    public void moveDown() {
        row++;
        for (Block block : blocks) {
            block.setPos(block.row() + 1, block.col());
        }
    }
    
    public int hardDrop() {
        int timesMovedDown = 0;
        while(canMove("down")) {
            moveDown();
            timesMovedDown += 2;
        }
        addToGrid();
        return timesMovedDown;
    }
    
    public void addToGrid() {
        for (Block block : blocks) {
            grid.setBlock(block.clone(), block.row(), block.col());
        }
    }
    
    public void setPos(int newRow, int newCol) {
        while(row < newRow) {
            move("down");
        }
        while(row > newRow) {
            move("up");
        }
        while(col < newCol) {
            move("right");
        }
        while(col > newCol) {
            move("left");
        }
    }
    
    public void move(String direction) {
        if (direction.equals("right")) {
            col++;
            for (Block block : blocks) {
                block.setPos(block.row(), block.col() + 1);
            }
        } else if (direction.equals("left")) {
            col--;
            for (Block block : blocks) {
                block.setPos(block.row(), block.col() - 1);
            }
        } else if (direction.equals("up")) {
            row--;
            for (Block block : blocks) {
                block.setPos(block.row() - 1, block.col());
            }
        } else if (direction.equals("down")) {
            row++;
            for (Block block : blocks) {
                block.setPos(block.row() + 1, block.col());
            }
        }
    }
    
    public boolean canMove(String direction) {
        for (Block block : blocks) {
            boolean right = (direction.equals("right") && (block.col() >= grid.width() - 1 || (isInBounds() && grid.getBlock(block.row(), block.col() + 1) != null)));
            boolean left = (direction.equals("left") && (block.col() <= 0 || (isInBounds() && grid.getBlock(block.row(), block.col() - 1) != null)));
            boolean up = (direction.equals("up") && (block.row() <= 0 || (isInBounds() && grid.getBlock(block.row() - 1, block.col()) != null)));
            boolean down = (direction.equals("down") && (block.row() >= grid.length() - 1 || (isInBounds() && grid.getBlock(block.row() + 1, block.col()) != null)));
            if (right || left || up || down)
                return false;
        }
        return true;
    }
    
    public boolean moveInBounds(boolean clockwise) {
        for (Block block : blocks) {
            while(block.row() < 0 && canMove("down"))
                move("down");
            while(block.row() >= grid.length() && canMove("up"))
                move("up");
            while(block.col() < 0 && canMove("right"))
                move("right");
            while(block.col() >= grid.width() && canMove("left"))
                move("left");
        }
        
        if (isInBounds())
            return true;
        
        move("up");
        if (isInBounds())
            return true;
        move("up");
        if (isInBounds())
            return true;
        move("down");
        move("down");
        rotate(!clockwise);
        return false;
    }
    
    public boolean isInBounds() {
        for (Block block : blocks) {
            if (block.row() < 0 || block.col() < 0 || block.row() >= grid.length() 
                || block.col() >= grid.width() || grid.getBlock(block.row(), block.col()) != null)
                return false;
        }
        return true;
    }
    
    public abstract Tetromino clone();
    
    public abstract boolean rotate(boolean clockwise);
    
    public abstract void reset();
    
    public abstract void displayGhost();
}