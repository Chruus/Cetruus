public class GUIMain extends GUI{
    Button play;
    ScoreFile file;
    
    public GUIMain(int scale_, color textColor, color backgroundColor, ScoreFile file_) {
        super(scale_);

        file = file_;

        play = new Button("Play", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        play.display();
        
        textAlign(CENTER);
        fill(255);
        textSize(scale * 3);
        
        text("Tetris", width / 2, 4 * scale);
        
        textSize(scale);
        
        text("Highest Score:\n" + file.hiScore(), width / 2, 7 * scale);
        text("Highest Lines:\n" + file.hiLines(), width / 2, 10 * scale);
        text("Highest Level:\n" + file.hiLevel(), width / 2, 13 * scale);
        
        popMatrix();
        popStyle();
    }
    
    public void mousePressed() {
        play.mousePressed();
    }
    
    public void mouseReleased() {
        play.mouseReleased();
    }
    
    public String goTo() {
        if (play.hasBeenPressed())
            return "new game";
        return "";
    }
}