import java.awt.event.KeyEvent;

public class GUISettingsKeyBindings extends GUI{
    private String newKeyBind;
    private Button moveLeft, moveRight, softDrop, hardDrop, hold, rotateRight, rotateLeft;
    
    public GUISettingsKeyBindings(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        moveLeft = new Button("Move Left", textColor, 4 * scale, 6 * scale, 6 * scale, 2 * scale, backgroundColor);
        moveRight = new Button("Move Right", textColor, 4 * scale, 8 * scale, 6 * scale, 2 * scale, backgroundColor);
        softDrop = new Button("Soft Drop", textColor, 4 * scale, 10 * scale, 6 * scale, 2 * scale, backgroundColor);
        hardDrop = new Button("Hard Drop", textColor, 4 * scale, 12 * scale, 6 * scale, 2 * scale, backgroundColor);
        hold = new Button("Hold", textColor, 4 * scale, 14 * scale, 6 * scale, 2 * scale, backgroundColor);
        rotateLeft = new Button("Rotate Left", textColor, 4 * scale, 16 * scale, 6 * scale, 2 * scale, backgroundColor);
        rotateRight = new Button("Rotate Right", textColor, 4 * scale, 18 * scale, 6 * scale, 2 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        moveLeft.display();
        moveRight.display();
        softDrop.display();
        hardDrop.display();
        hold.display();
        rotateLeft.display();
        rotateRight.display();
        
        textAlign(CENTER);
        textSize(24);
        fill(255);
        
        
        text("\"" + KeyEvent.getKeyText(keyBinds.get("move left")) + "\"", 10 * scale, 6 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("move right")) + "\"", 10 * scale, 8 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("soft drop")) + "\"", 10 * scale, 10 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("hard drop")) + "\"", 10 * scale, 12 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("hold tetro")) + "\"", 10 * scale, 14 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("rotate left")) + "\"", 10 * scale, 16 * scale + 5);
        text("\"" + KeyEvent.getKeyText(keyBinds.get("rotate right")) + "\"", 10 * scale, 18 * scale + 5);
        
        checkForNewSettings();
        
        popMatrix();
        popStyle();
    }
    
    private void checkForNewSettings() {
        String goTo = goTo();
        
        if (goTo.equals("") || goTo.equals("back"))
            return;
        
        newKeyBind = goTo;
    }
    
    public void keyPressed() {
        if (newKeyBind.equals(""))
            return;
        
        keyBinds.set(newKeyBind, keyCode); 
        newKeyBind = "";
        
    }
    
    public void mousePressed() {
        moveLeft.mousePressed();
        moveRight.mousePressed();
        softDrop.mousePressed();
        hardDrop.mousePressed();
        hold.mousePressed();
        rotateLeft.mousePressed();
        rotateRight.mousePressed();
    }
    
    public void mouseReleased() {
        moveLeft.mouseReleased();
        moveRight.mouseReleased();
        softDrop.mouseReleased();
        hardDrop.mouseReleased();
        hold.mouseReleased();
        rotateLeft.mouseReleased();
        rotateRight.mouseReleased();
    }
    
    public String goTo() {
        if (moveLeft.hasBeenPressed())
            return "move left";
        if (moveRight.hasBeenPressed())
            return "move right";
        if (softDrop.hasBeenPressed())
            return "soft drop";
        if (hardDrop.hasBeenPressed())
            return "hard drop";
        if (hold.hasBeenPressed())
            return "hold tetro";
        if (rotateLeft.hasBeenPressed())
            return "rotate left";
        if (rotateRight.hasBeenPressed())
            return "rotate right";
        return "";
    }
}