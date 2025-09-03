public class Block{
    private color clr;
    private int row, col;
    
    public Block(float row_, float col_, color clr_) {
        row = (int) row_;
        col = (int) col_;
        clr = clr_;
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        int x = width / 2 + (col - 6) * Cetruus.scale - Cetruus.scale / 2;
        int y = height / 2 + (row - 9) * Cetruus.scale - Cetruus.scale / 2;
        rectMode(CENTER);
        strokeWeight(0);
        fill(clr);
        rect(x, y, Cetruus.scale * 0.9, Cetruus.scale * 0.9, 4, 4, 4, 4);
        
        popMatrix();
        popStyle();
    }
    
    public void display(int opacity) {
        pushStyle();
        pushMatrix();
        
        int x = width / 2 + (col - 6) * Cetruus.scale - Cetruus.scale / 2;
        int y = height / 2 + (row - 9) * Cetruus.scale - Cetruus.scale / 2;
        rectMode(CENTER);
        strokeWeight(0);
        fill(clr, opacity);
        rect(x, y, Cetruus.scale * 0.9, Cetruus.scale * 0.9, 4, 4, 4, 4);
        
        popMatrix();
        popStyle();
    }
    
    public void setPos(float newRow, float newCol) {
        row = (int) newRow;
        col = (int) newCol;
    }
    
    public int row() {
        return row;
    }
    
    public int col() {
        return col;
    }
    
    public color clr() {
        return clr;
    }
    
    public Block clone() {
        return new Block(row, col, clr);
    }
    
    public String toString() {
        return clr + " " + row + " " + col;
    }
}