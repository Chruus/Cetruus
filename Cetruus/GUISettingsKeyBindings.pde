import java.awt.event.KeyEvent;

public class GUISettingsKeyBindings extends GUI{
    private String newKeyBind;
    private Button moveLeft, moveRight, softDrop, hardDrop, hold, rotateRight, rotateLeft;
    
    public GUISettingsKeyBindings(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        moveLeft = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("move left")) + "\"", textColor, 11 * scale, 6 * scale, 5 * scale, 2 * scale, backgroundColor);
        moveRight = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("move right")) + "\"", textColor, 11 * scale, 8 * scale, 5 * scale, 2 * scale, backgroundColor);
        softDrop = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("soft drop")) + "\"", textColor, 11 * scale, 10 * scale, 5 * scale, 2 * scale, backgroundColor);
        hardDrop = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("hard drop")) + "\"", textColor, 11 * scale, 12 * scale, 5 * scale, 2 * scale, backgroundColor);
        hold = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("hold tetro")) + "\"", textColor, 11 * scale, 14 * scale, 5 * scale, 2 * scale, backgroundColor);
        rotateLeft = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("rotate left")) + "\"", textColor, 11 * scale, 16 * scale, 5 * scale, 2 * scale, backgroundColor);
        rotateRight = new Button("\"" + KeyEvent.getKeyText(keyBinds.get("rotate right")) + "\"", textColor, 11 * scale, 18 * scale, 5 * scale, 2 * scale, backgroundColor);        
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
        
        textAlign(LEFT);
        textSize(18);
        fill(255);
        
        text("move left",(int)(0.5 * scale), 6 * scale + 10);
        text("move right",(int)(0.5 * scale), 8 * scale + 10);
        text("soft drop",(int)(0.5 * scale), 10 * scale + 10);
        text("hard drop",(int)(0.5 * scale), 12 * scale + 10);
        text("hold tetromino",(int)(0.5 * scale), 14 * scale + 10);
        text("rotate left",(int)(0.5 * scale), 16 * scale + 10);
        text("rotate right",(int)(0.5 * scale), 18 * scale + 10);
        
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
        
        switch(newKeyBind) {
            case "":
                break;
            case "move left":
                moveLeft.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "move right":
                moveRight.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "soft drop":
                softDrop.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "hard drop":
                hardDrop.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "hold tetro":
                hold.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "rotate left":
                rotateLeft.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
            case "rotate right":
                rotateRight.setText("\"" + KeyEvent.getKeyText(keyCode) + "\"");
                break;
        }
        
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