public class GUISettingsDAS extends GUI{
    Button initialDASUp, initialDASDown, DASUp, DASDown;
    color textColor, backgroundColor;
    
    public GUISettingsDAS(color textColor, color backgroundColor) {
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        int xUp = width / 2 - 3 * Cetruus.scale;
        int xDown = width / 2 + 3 * Cetruus.scale;
        int yIDAS = height / 2 - 3 * Cetruus.scale;
        int yDAS = height / 2 + 2 * Cetruus.scale;
        int wh = 2 * Cetruus.scale;
        int textSize = (int)(0.5 * Cetruus.scale);
        
        initialDASDown = new Button("-1", textColor, xUp, yIDAS,  wh,  wh, textSize, backgroundColor);
        initialDASUp = new Button("+1", textColor, xDown, yIDAS,  wh,  wh, textSize, backgroundColor);
        DASDown = new Button("-1", textColor, xUp, yDAS,  wh,  wh, textSize, backgroundColor);
        DASUp = new Button("+1", textColor, xDown, yDAS,  wh,  wh, textSize, backgroundColor);
    }
    
    public void display() {
        checkForChanges();
        
        pushStyle();
        pushMatrix();
        
        initialDASUp.display();
        initialDASDown.display();
        DASUp.display();
        DASDown.display();
        
        rectMode(CENTER);
        fill(0);
        rect(width / 2, height / 2 - Cetruus.scale * 3, 4 * Cetruus.scale, 2 * Cetruus.scale);
        rect(width / 2, height / 2 + Cetruus.scale * 2, 4 * Cetruus.scale, 2 * Cetruus.scale);
        
        fill(255);
        textAlign(CENTER);
        textSize(Cetruus.scale * 2 / 3);
        text("Initial Delayed Auto Shift", width / 2, height / 2 - Cetruus.scale * 4.5);
        text(keyBinds.initialDAS(), width / 2, height / 2 - Cetruus.scale * 2.5);
        text("Delayed Auto Shift Speed", width / 2, height / 2 + Cetruus.scale * 0.5);
        text(keyBinds.DAS(), width / 2, height / 2 + Cetruus.scale * 2.5);
        
        popMatrix();
        popStyle();
    }
    
    public void windowResized() {
        int xUp = width / 2 - 3 * Cetruus.scale;
        int xDown = width / 2 + 3 * Cetruus.scale;
        int yIDAS = height / 2 - 3 * Cetruus.scale;
        int yDAS = height / 2 + 2 * Cetruus.scale;
        int wh = 2 * Cetruus.scale;
        int textSize = (int)(0.5 * Cetruus.scale);
        
        initialDASUp.resize(xUp, yIDAS, wh, wh);
        initialDASDown.resize(xDown, yIDAS, wh, wh);
        DASUp.resize(xUp, yDAS, wh, wh);
        DASDown.resize(xDown, yDAS, wh, wh);
    }
    
    private void checkForChanges() {
        if (initialDASUp.hasBeenPressed() && keyBinds.initialDAS() < 127)
            keyBinds.setInitialDAS(keyBinds.initialDAS() + 1);
        else if (initialDASDown.hasBeenPressed() && keyBinds.initialDAS() > 1)
            keyBinds.setInitialDAS(keyBinds.initialDAS() - 1);
        else if (DASUp.hasBeenPressed() && keyBinds.DAS() < 127)
            keyBinds.setDAS(keyBinds.DAS() + 1);
        else if (DASDown.hasBeenPressed() && keyBinds.DAS() > 1)
            keyBinds.setDAS(keyBinds.DAS() - 1);
        else 
            return;
        
        file.saveDelays();
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        initialDASUp.mousePressed();
        initialDASDown.mousePressed();
        DASUp.mousePressed();
        DASDown.mousePressed();
    }
    
    public void mouseReleased() {
        initialDASUp.mouseReleased();
        initialDASDown.mouseReleased();
        DASUp.mouseReleased();
        DASDown.mouseReleased();
    }
    
    public String goTo() {
        return "";
    }
}