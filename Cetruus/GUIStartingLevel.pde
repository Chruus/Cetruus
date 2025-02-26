public class GuiStartingLevel extends GUI{
    
    Button play, levelUp, levelDown;
    int level;
    
    public GuiStartingLevel(int scale_, color textColor, color backgroundColor) {
        super(scale_);               
        play = new Button("Play", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        levelUp = new Button("+1", textColor, 10 * scale, 7 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
        levelDown = new Button("-1", textColor, 4 * scale, 7 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
        level = stats.getStartingLevel();
    }
    
    public void display() {
        play.display();
        levelUp.display();
        levelDown.display();
        if (levelUp.hasBeenPressed() && level < 20 && level < file.hiLevel())
            level++;
        if (levelDown.hasBeenPressed() && level > 1)
            level--;
        
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        fill(0);
        rect(width / 2, scale * 7, 4 * scale, 2 * scale);
        
        fill(255);
        textAlign(CENTER);
        textSize(20);
        text("Starting Level", width / 2, scale * 5.5);
        text(level, width / 2, scale * 7 + 16);
        
        popMatrix();
        popStyle();
    }
    
    public void keyPressed() {
    }
    
    public void mousePressed() {
        play.mousePressed();
        levelUp.mousePressed();
        levelDown.mousePressed();
    }
    
    public void mouseReleased() {
        play.mouseReleased();
        levelUp.mouseReleased();
        levelDown.mouseReleased();
    }
    
    public String goTo() {
        if (play.hasBeenPressed()) {
            UI.setStartingLevel(level);
            return "new game";
        }
        return "";
    }
}