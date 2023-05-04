public class GUIScores extends GUI{
    Button back;
    ScoreFile file;
    
    public GUIScores(int scale_, color textColor, color backgroundColor, ScoreFile file_) {
        super(scale_);
        
        file = file_;
        
        back = new Button("Back", textColor, 2 * scale, 1 * scale, 4 * scale, 2 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        back.display();
        
        fill(255);
        textSize(scale * 0.6);
        textAlign(LEFT);
        
        text("Highest Score:", 1 * scale, 4 * scale);
        text("Most Lines Cleared:", 1 * scale, 5 * scale);
        text("Highest Level Reached:", 1 * scale, 6 * scale);
        
        textAlign(RIGHT);
        
        text(file.hiScore(), 13 * scale, 4 * scale);
        text(file.hiLines(), 13 * scale, 5 * scale);
        text(file.hiLevel(), 13 * scale, 6 * scale);
        
        popMatrix();
        popStyle();
    }
    
    public void mousePressed() {
        back.mousePressed();
    }
    
    public void mouseReleased() {
        back.mouseReleased();
    }
    
    public String goTo() {
        if (back.hasBeenPressed())
            return "main";
        return "";
    }
}