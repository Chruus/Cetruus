import java.awt.event.KeyEvent;

public class GUISettingsKeyBindings extends GUI{
    private String newKeyBind;
    private Button moveLeft, moveRight, softDrop, hardDrop, hold, rotateRight, rotateLeft;
    color textColor, backgroundColor;
    
    public GUISettingsKeyBindings(color textColor, color backgroundColor) {
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        String moveLeftText = "\"" + KeyEvent.getKeyText(keyBinds.get("move left")) + "\"";
        String moveRightText = "\"" + KeyEvent.getKeyText(keyBinds.get("move right")) + "\"";
        String softDropText = "\"" + KeyEvent.getKeyText(keyBinds.get("soft drop")) + "\"";
        String hardDropText = "\"" + KeyEvent.getKeyText(keyBinds.get("hard drop")) + "\"";
        String holdText = "\"" + KeyEvent.getKeyText(keyBinds.get("hold tetro")) + "\"";
        String rotateLeftText = "\"" + KeyEvent.getKeyText(keyBinds.get("rotate left")) + "\"";
        String rotateRightText = "\"" + KeyEvent.getKeyText(keyBinds.get("rotate right")) + "\"";
        
        int X = width / 2 + 4 * Cetruus.scale;
        int moveLeftY = height / 2 - 4 * Cetruus.scale;
        int moveRightY = height / 2 - 2 * Cetruus.scale;
        int softDropY = height / 2;
        int hardDropY = height / 2 + 2 * Cetruus.scale;
        int holdY = height / 2 + 4 * Cetruus.scale;
        int rotateLeftY = height / 2 + 6 * Cetruus.scale;
        int rotateRightY = height / 2 + 8 * Cetruus.scale;
        int width = 5 * Cetruus.scale;
        int height = 2 * Cetruus.scale;
        
        moveLeft = new Button(moveLeftText, textColor, X, moveLeftY, width, height, backgroundColor);
        moveRight = new Button(moveRightText, textColor, X, moveRightY, width, height, backgroundColor);
        softDrop = new Button(softDropText, textColor, X, softDropY, width, height, backgroundColor);
        hardDrop = new Button(hardDropText, textColor, X, hardDropY, width, height, backgroundColor);
        hold = new Button(holdText, textColor, X, holdY, width, height, backgroundColor);
        rotateLeft = new Button(rotateLeftText, textColor, X, rotateLeftY, width, height, backgroundColor);
        rotateRight = new Button(rotateRightText, textColor, X, rotateRightY, width, height, backgroundColor);        
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
        textSize(Cetruus.scale * 3 / 5);
        fill(255);
        
        int x = width / 2 - (int)(6.5 * Cetruus.scale);
        int moveLeftY = height / 2 - 4 * Cetruus.scale + (int)(Cetruus.scale / 3);
        int moveRightY = height / 2 - 2 * Cetruus.scale + (int)(Cetruus.scale / 3);
        int softDropY = height / 2 + (int)(Cetruus.scale / 3);
        int hardDropY = height / 2 + 2 * Cetruus.scale + (int)(Cetruus.scale / 3);
        int holdTetroY = height / 2 + 4 * Cetruus.scale + (int)(Cetruus.scale / 3);
        int rotateLeftY = height / 2 + 6 * Cetruus.scale + (int)(Cetruus.scale / 3);
        int rotateRightY = height / 2 + 8 * Cetruus.scale + (int)(Cetruus.scale / 3);
        
        text("move left", x, moveLeftY);
        text("move right", x, moveRightY);
        text("soft drop", x, softDropY);
        text("hard drop", x, hardDropY);
        text("hold tetromino", x, holdTetroY);
        text("rotate left", x, rotateLeftY);
        text("rotate right", x, rotateRightY);
        
        checkForNewSettings();
        
        popMatrix();
        popStyle();
    }
    
    public void windowResized() {
        int X = width / 2 + 4 * Cetruus.scale;
        int moveLeftY = height / 2 - 4 * Cetruus.scale;
        int moveRightY = height / 2 - 2 * Cetruus.scale;
        int softDropY = height / 2;
        int hardDropY = height / 2 + 2 * Cetruus.scale;
        int holdY = height / 2 + 4 * Cetruus.scale;
        int rotateLeftY = height / 2 + 6 * Cetruus.scale;
        int rotateRightY = height / 2 + 8 * Cetruus.scale;
        int width = 5 * Cetruus.scale;
        int height = 2 * Cetruus.scale;
        
        moveLeft.resize(X, moveLeftY, width, height);
        moveRight.resize(X, moveRightY, width, height);
        softDrop.resize(X, softDropY, width, height);
        hardDrop.resize(X, hardDropY, width, height);
        hold.resize(X, holdY, width, height);
        rotateLeft.resize(X, rotateLeftY, width, height);
        rotateRight.resize(X, rotateRightY, width, height);
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