public class Block{
    private color clr;
    private int row, col, scale;
    
    public Block(float row_, float col_, int scale_, color clr_) {
        row = (int) row_;
        col = (int) col_;
        clr = clr_;
        scale = scale_;
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        int x = (col + 1) * scale - scale / 2;
        int y = (row + 1) * scale - scale / 2;
        rectMode(CENTER);
        strokeWeight(0);
        fill(clr);
        rect(x, y, scale * 0.9, scale * 0.9, 4, 4, 4, 4);
        
        popMatrix();
        popStyle();
    }
    
    public void display(int opacity) {
        pushStyle();
        pushMatrix();
        
        int x = (col + 1) * scale - scale / 2;
        int y = (row + 1) * scale - scale / 2;
        rectMode(CENTER);
        strokeWeight(0);
        fill(clr, opacity);
        rect(x, y, scale * 0.9, scale * 0.9, 4, 4, 4, 4);
        
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
        return new Block(row, col, scale, clr);
    }
}