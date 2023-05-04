public class Grid{
    Block[][] grid;
    int addToGridDelay;
    
    public Grid() {
        grid = new Block[20][10];
        addToGridDelay = 30;
    }
    
    public void display() {
        for (int r = 0; r < grid.length; r++) {
            for (int c = 0; c < grid[r].length; c++) {
                if (grid[r][c] != null)
                    grid[r][c].display();
            }
        }
    }
    
    public boolean canAddTetromino(Tetromino currentTetromino) {
        if (currentTetromino.canMove("down")) {
            if (addToGridDelay < 30)
                addToGridDelay++;
            return false;
        }
        
        if (addToGridDelay > 0) {
            addToGridDelay--;
            return false;
        }
        addToGridDelay = 30;
        return true;
    }
    
    public void clearFullRows() {
        ArrayList<Integer> fullRows = getFullRows();
        if (fullRows.size() == 0)
            return;
        
        for (int row : fullRows) {
            shiftGridDown(row);
        }
        
        calculateScore(fullRows.size());
    }
    
    private ArrayList<Integer> getFullRows() {
        ArrayList<Integer> fullRows = new ArrayList<Integer>();
        for (int r = 0; r < grid.length; r++) {
            boolean isFullRow = true;
            for (int c = 0; c < grid[r].length; c++) {
                if (grid[r][c] == null) {
                    isFullRow = false;
                    break;
                }
            }
            if (isFullRow) {
                fullRows.add(r);
            }
        }
        return fullRows;
    }
    
    private void shiftGridDown(int row) {
        for (int r = row; r > 0; r--) {
            for (int c = 0; c < grid[r].length; c++) {
                grid[r][c] = grid[r - 1][c];
                if (grid[r][c] != null)
                    grid[r][c].setPos(r, c);
            }
        }
        for (int c = 0; c < grid[0].length; c++) {
            grid[0][c] = null;
        }
    }
    
    public String toString() {
        String output = "";
        
        for (int r = 0; r < grid.length; r++) {
            for (int c = 0; c < grid[r].length; c++) {
                output += "[";
                if (grid[r][c] != null)
                    output += grid[r][c].clr();
                output += ']';
            }
            output += "\n";
        }
        
        return output;
    }
    
    public void setBlock(Block block, int row, int col) {
        grid[row][col] = block;
    }
    
    public Block getBlock(int row, int col) {
        return grid[row][col];
    }
    
    public int length() {
        return grid.length;
    }
    
    public int width() {
        return grid[0].length;
    }
}