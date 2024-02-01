public class GUISettingsMisc extends GUI{
    Button initialKeyDelayUp, initialKeyDelayDown, keyDelayUp, keyDelayDown;
    
    public GUISettingsMisc(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        initialKeyDelayDown = new Button("-1", textColor, 4 * scale, 6 * scale, 2 * scale, 2 * scale, backgroundColor);
        initialKeyDelayUp = new Button("+1", textColor, 10 * scale, 6 * scale, 2 * scale, 2 * scale, backgroundColor);
        keyDelayDown = new Button("-1", textColor, 4 * scale, 10 * scale, 2 * scale, 2 * scale, backgroundColor);
        keyDelayUp = new Button("+1", textColor, 10 * scale, 10 * scale, 2 * scale, 2 * scale, backgroundColor);
    }
    
    public void display() {
        checkForChanges();
        
        pushStyle();
        pushMatrix();
        
        initialKeyDelayUp.display();
        initialKeyDelayDown.display();
        keyDelayUp.display();
        keyDelayDown.display();
        
        rectMode(CENTER);
        fill(0);
        rect(width / 2, scale * 6, 4 * scale, 2 * scale);
        rect(width / 2, scale * 10, 4 * scale, 2 * scale);
        
        fill(255);
        textAlign(CENTER);
        textSize(20);
        text("Repeated Key Delay", width / 2, scale * 4.5);
        text(keyBinds.initialKeyDelay(), width / 2, scale * 6 + 8);
        text("Repeated Key Speed", width / 2, scale * 8.5);
        text(keyBinds.keyDelay(), width / 2, scale * 10 + 8);
        
        popMatrix();
        popStyle();
    }
    
    private void checkForChanges() {
        if (initialKeyDelayUp.hasBeenPressed())
            keyBinds.setInitialKeyDelay(keyBinds.initialKeyDelay() + 1);
        else if (initialKeyDelayDown.hasBeenPressed())
            keyBinds.setInitialKeyDelay(keyBinds.initialKeyDelay() - 1);
        else if (keyDelayUp.hasBeenPressed())
            keyBinds.setKeyDelay(keyBinds.keyDelay() + 1);
        else if (keyDelayDown.hasBeenPressed())
            keyBinds.setKeyDelay(keyBinds.keyDelay() - 1);
        else 
            return;
        
        file.saveDelays();
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        initialKeyDelayUp.mousePressed();
        initialKeyDelayDown.mousePressed();
        keyDelayUp.mousePressed();
        keyDelayDown.mousePressed();
    }
    
    public void mouseReleased() {
        initialKeyDelayUp.mouseReleased();
        initialKeyDelayDown.mouseReleased();
        keyDelayUp.mouseReleased();
        keyDelayDown.mouseReleased();
    }
    
    public String goTo() {
        return "";
    }
}