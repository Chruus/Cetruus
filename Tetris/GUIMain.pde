public class GUIMain extends GUI{
    Button play, scores, settings;
    
    public GUIMain(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        play = new Button("Play", textColor, width / 2, 9 * scale, 10 * scale, 3 * scale, backgroundColor);
        scores = new Button("High Scores", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        settings = new Button("Settings", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        play.display();
        scores.display();
        settings.display();
        
        textAlign(CENTER);
        fill(255);
        textSize(scale * 3);
        
        text("Tetris", width / 2, 4 * scale);
        
        popMatrix();
        popStyle();
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        play.mousePressed();
        scores.mousePressed();
        settings.mousePressed();
    }
    
    public void mouseReleased() {
        play.mouseReleased();
        scores.mouseReleased();
        settings.mouseReleased();
    }
    
    public String goTo() {
        if (play.hasBeenPressed())
            return "new game";
        if (scores.hasBeenPressed())
            return "scores";
        if (settings.hasBeenPressed())
            return "settings";
        return "";
    }
}