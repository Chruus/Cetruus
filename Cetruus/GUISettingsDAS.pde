public class GUISettingsDAS extends GUI{
    Button initialDASUp, initialDASDown, DASUp, DASDown;
    
    public GUISettingsDAS(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        initialDASDown = new Button("-1", textColor, 4 * scale, 7 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
        initialDASUp = new Button("+1", textColor, 10 * scale, 7 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
        DASDown = new Button("-1", textColor, 4 * scale, 12 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
        DASUp = new Button("+1", textColor, 10 * scale, 12 * scale, 2 * scale, 2 * scale,(int)(0.5 * scale), backgroundColor);
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
        rect(width / 2, scale * 7, 4 * scale, 2 * scale);
        rect(width / 2, scale * 12, 4 * scale, 2 * scale);
        
        fill(255);
        textAlign(CENTER);
        textSize(20);
        text("Initial Delayed Auto Shift", width / 2, scale * 5.5);
        text(keyBinds.initialDAS(), width / 2, scale * 7 + 16);
        text("Delayed Auto Shift Speed", width / 2, scale * 10.5);
        text(keyBinds.DAS(), width / 2, scale * 12 + 16);
        
        popMatrix();
        popStyle();
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