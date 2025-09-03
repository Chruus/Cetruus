public class GUIGameOver extends GUI{
    Button playAgain, returnToMain;
    Stats stats;
    color textColor, backgroundColor;
    
    public GUIGameOver(color textColor, color backgroundColor, Stats stats_) {
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        stats = stats_;
        
        int X = width / 2;
        int playAgainY = height / 2 + Cetruus.scale * 3;
        int returnToMainY = height / 2 + Cetruus.scale * 7;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        playAgain = new Button("Play Again", textColor, X, playAgainY, width, height, backgroundColor);
        returnToMain = new Button("Main Menu", textColor, X, returnToMainY, width, height, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        playAgain.display();
        returnToMain.display();
        
        textAlign(CENTER);
        textFont(font);
        textSize((int)(Cetruus.scale * 0.65));
        fill(255);
        
        text("Score:", width / 2, 3 * Cetruus.scale);
        text(stats.score(), width / 2, 4.25 * Cetruus.scale);
        text("Lines:", width / 2, 6 * Cetruus.scale);
        text(stats.lines(), width / 2, 7.25 * Cetruus.scale);
        text("Level:", width / 2, 9 * Cetruus.scale);
        text(stats.level(), width / 2, 10.25 * Cetruus.scale);
        
        popMatrix();
        popStyle();        
    }
    
    public void windowResized() {
        int X = width / 2;
        int playAgainY = height / 2 + Cetruus.scale * 3;
        int returnToMainY = height / 2 + Cetruus.scale * 7;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        
        playAgain.resize(X, playAgainY, width, height);
        returnToMain.resize(X, returnToMainY, width, height);
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