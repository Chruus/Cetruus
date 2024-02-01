public class GUIGameOver extends GUI{
    Button playAgain, returnToMain;
    Stats stats;
    
    public GUIGameOver(int scale_, color textColor, color backgroundColor, Stats stats_) {
        super(scale_);
        
        stats = stats_;
        
        playAgain = new Button("Play Again", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        returnToMain = new Button("Return to Menu", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        playAgain.display();
        returnToMain.display();
        
        textAlign(CENTER);
        textFont(font);
        textSize(scale);
        fill(255);
        
        text("Score:", width / 2, 3 * scale);
        text(stats.score(), width / 2, 4.25 * scale);
        text("Lines:", width / 2, 6 * scale);
        text(stats.lines(), width / 2, 7.25 * scale);
        text("Level:", width / 2, 9 * scale);
        text(stats.level(), width / 2, 10.25 * scale);
        
        popMatrix();
        popStyle();        
    }
    
    public String goTo() {
        if (playAgain.hasBeenPressed())
            return "new game";
        if (returnToMain.hasBeenPressed())
            return "main";
        return "";
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        playAgain.mousePressed();
        returnToMain.mousePressed();
    }
    
    public void mouseReleased() {        
        playAgain.mouseReleased();
        returnToMain.mouseReleased();
    }
}