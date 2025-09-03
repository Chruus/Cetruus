public class GuiStartingLevel extends GUI{
    
    Button play, levelUp, levelDown;
    int level;
    color textColor, backgroundColor;
    
    
    public GuiStartingLevel(color textColor, color backgroundColor) {     
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        int xPlay = width / 2;
        int xUp = width / 2 + 3 * Cetruus.scale;
        int xDown = width / 2 - 3 * Cetruus.scale;
        int yPlay = height / 2 + 3 * Cetruus.scale;
        int yLvl = height / 2 - 3 * Cetruus.scale;
        int wPlay = 10 * Cetruus.scale;
        int hPlay = 3 * Cetruus.scale;
        int whLvl = 2 * Cetruus.scale;
        int textSize = (int)(0.5 * Cetruus.scale);
        
        play = new Button("Play", textColor, xPlay, yPlay, wPlay, hPlay, backgroundColor);
        levelUp = new Button("+1", textColor, xUp, yLvl, whLvl, whLvl, textSize, backgroundColor);
        levelDown = new Button("-1", textColor, xDown, yLvl, whLvl, whLvl, textSize, backgroundColor);
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
        rect(width / 2, height / 2 - Cetruus.scale * 3, 4 * Cetruus.scale, 2 * Cetruus.scale);
        
        fill(255);
        textAlign(CENTER);
        textSize(Cetruus.scale * 2 / 3);
        text("Starting Level", width / 2, height / 2 - Cetruus.scale * 4.5);
        text(level, width / 2, height / 2 - Cetruus.scale * 2.5);
        
        popMatrix();
        popStyle();
    }
    
    public void windowResized() {
        int xPlay = width / 2;
        int xUp = width / 2 + 3 * Cetruus.scale;
        int xDown = width / 2 - 3 * Cetruus.scale;
        int yPlay = height / 2 + 3 * Cetruus.scale;
        int yLvl = height / 2 - 3 * Cetruus.scale;
        int wPlay = 10 * Cetruus.scale;
        int hPlay = 3 * Cetruus.scale;
        int whLvl = 2 * Cetruus.scale;
        int textSize = (int)(0.5 * Cetruus.scale);
        
        play.resize(xPlay, yPlay, wPlay, hPlay);
        levelUp.resize(xUp, yLvl, whLvl, whLvl);
        levelDown.resize(xDown, yLvl, whLvl, whLvl);
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