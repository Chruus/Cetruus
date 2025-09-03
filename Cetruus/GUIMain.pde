public class GUIMain extends GUI{
    Button play, settings;
    color textColor, backgroundColor;
    
    public GUIMain(color textColor, color backgroundColor) {
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        int X =  width / 2;
        int playY = 13 * Cetruus.scale;
        int settingsY = 17 * Cetruus.scale;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        play = new Button("Play", textColor, X, playY, width, height, backgroundColor);
        settings = new Button("Settings", textColor, X, settingsY, width, height, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        play.display();
        settings.display();
        
        textAlign(CENTER);
        fill(255);
        textSize(Cetruus.scale * 1.8);
        
        text("Cetruus", width / 2 + Cetruus.scale / 5, height / 2 - 5 * Cetruus.scale);
        
        fill(255);
        textSize(Cetruus.scale * 0.4);
        textAlign(CENTER);
        
        if (file.hiScore() != 0 || file.hiLines() != 0 || file.hiLevel() != 0) {
            text("Hi Score: " + file.hiScore(), width / 2, height / 2 - 2 * Cetruus.scale);
            text("Hi Lines: " + file.hiLines(), width / 2, height / 2 - Cetruus.scale);
            text("Hi Level: " + file.hiLevel(), width / 2, height / 2);
        }
        
        popMatrix();
        popStyle();
    }
    
    public void windowResized() {
        int X =  width / 2;
        int playY = height / 2 + 3 * Cetruus.scale;
        int settingsY = height / 2 + 7 * Cetruus.scale;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        
        play.resize(X, playY, width, height);
        settings.resize(X, settingsY, width, height);
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        play.mousePressed();
        settings.mousePressed();
    }
    
    public void mouseReleased() {
        play.mouseReleased();
        settings.mouseReleased();
    }
    
    public String goTo() {
        if (play.hasBeenPressed())
            return "starting level";
        if (settings.hasBeenPressed())
            return "settings";
        return "";
    }
}