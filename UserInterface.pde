public class UserInterface{
    int scale;
    public UserInterface(int scale_){
        scale = scale_;
    }

    public void displayHeldPiece(Tetromino piece){
        if(piece == null)
            return;
        Tetromino heldPiece = piece.clone();
        heldPiece.reset();
        heldPiece.setPos(2, 12);
        heldPiece.display();
    }

    public void displayFuturePieces(ArrayList<Tetromino> pieces){
        pieces.get(0).setPos(6, 12);
        pieces.get(1).setPos(9, 12);
        pieces.get(2).setPos(12, 12);
        for(Tetromino piece : pieces){
            piece.display();
        }
    }

    public void displayMenu(){
        
    }

    public void displayGameOver(){
        pushStyle();
        pushMatrix();

        background(0, 100);
        color backgroundColor = new Color(225, 225, 255);
        color textColor = new Color(0);
        Button playAgain = new Button("Play Again", textColor, width / 2, 15 * scale, 5 * scale, 2 * scale, backgroundColor);
        Button backToMenu = new Button("Back To Menu", textColor, width / 2, 17 * scale, 5 * scale, 2 * scale, backgroundColor);
    
        textAlign(CENTER);
        textSize(scale);
        fill(255);
        
        text("Score:\n" + score, width / 2, 8 * scale);
        text("Lines:\n" + linesCleared, width / 2, 10 * scale);
        text("Level:\n" + level, 2idth / 2, 12 * scale);

        popMatrix();
        popStyle();

    }

    public void displayCurrentStats(int score, int linesCleared, int level){
        pushStyle();
        pushMatrix();

        textAlign(LEFT);
        textSize(scale * 0.5);
        fill(255);

        int x = scale / 2 * 21;
        int y = scale * 17;
        
        text("Score:\n" + score, x, y - scale * 1.65);
        text("Lines:\n" + linesCleared, x, y);
        text("Level:\n" + level, x, y + scale * 1.65);

        popMatrix();
        popStyle();
    }
}