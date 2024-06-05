public class GUIMain extends GUI{
    Button play, scores, settings;
    
    public GUIMain(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        play = new Button("Play", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        scores = new Button("High Scores", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        settings = new Button("Settings", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        play.display();
        //scores.display();
        settings.display();
        
        textAlign(CENTER);
        fill(255);
        textSize(scale * 1.8);
        
        text("Cetruus", width / 2 + scale / 5, 5 * scale);
        
        fill(255);
        textSize(scale * 0.4);
        textAlign(CENTER);
        
        text("Hi Score: " + file.hiScore(), width / 2, 8 * scale);
        text("Hi Lines: " + file.hiLines(), width / 2, 9 * scale);
        text("Hi Level: " + file.hiLevel(), width / 2, 10 * scale);
        
        
        //text(file.hiScore(), 7 * scale, 8 * scale);
        //text(file.hiLines(), 7 * scale, 9 * scale);
        //text(file.hiLevel(), 7 * scale, 10 * scale);
        
        popMatrix();
        popStyle();
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        play.mousePressed();
        //scores.mousePressed();
        settings.mousePressed();
    }
    
    public void mouseReleased() {
        play.mouseReleased();
        //scores.mouseReleased();
        settings.mouseReleased();
    }
    
    public String goTo() {
        if (play.hasBeenPressed())
            return "new game";
        //if (scores.hasBeenPressed())
        //    return "scores";
        if (settings.hasBeenPressed())
            return "settings";
        return "";
    }
}