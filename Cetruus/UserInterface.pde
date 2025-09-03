import processing.sound.*;

public class UserInterface{
    Block[][] background;
    boolean needToResetGame, inGame, inPause;
    GUI currentGUI, gameOver, main, pause, settings, keyBinds, selectStartingLevel;
    int startingLevel;
    Stats stats;
    color backgroundColor, textColor;
    
    public UserInterface(Stats stats_) {
        stats = stats_;
        
        backgroundColor = color(225, 225, 255);
        textColor = color(0);
        
        gameOver = new GUIGameOver(textColor, backgroundColor, stats);
        main = new GUIMain(textColor, backgroundColor);
        pause = new GUIPause(textColor, backgroundColor);
        settings = new GUISettings(textColor, backgroundColor);
        selectStartingLevel = new GuiStartingLevel(textColor, backgroundColor);
        currentGUI = main;
        
        resetBackground();
    }
    
    public void display() {
        displayBackground();
        currentGUI.display();
        checkGoto("");
    }
    
    private void checkGoto(String goTo) {
        if (goTo == "")
            goTo = currentGUI.goTo();
        
        if (goTo.equals(""))
            return;
        if (goTo.equals("main")) 
            currentGUI = main;
        if (goTo.equals("settings"))
            currentGUI = settings;
        if (goTo.equals("game")) {
            currentGUI = null;
            inGame = true;
        }
        if (goTo.equals("starting level"))
            currentGUI = selectStartingLevel;
        if (goTo.equals("new game")) {
            currentGUI = null;
            inGame = needToResetGame = true;
        }
    }
    
    public void displayBackground() {
        int maxHeight = height / 2 + Cetruus.scale * 10;
        int maxWidth = width / 2 + Cetruus.scale * 7;
        int xOffset = Math.max(width / 2 - Cetruus.scale * 7, 0);
        int yOffset = Math.max(height / 2 - Cetruus.scale * 10, 0);
        
        background(25);
        for (int r = 0; background[r][0].row() * Cetruus.scale + yOffset < maxHeight; r++) {
            for (int c = 0; background[r][c].col() * Cetruus.scale + xOffset < maxWidth; c++) {
                background[r][c].display();
            }
        }
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        fill(20, 230);
        rect(width / 2, height / 2, 4000, 4000);
        
        popMatrix();
        popStyle();
    }
    
    public void setStartingLevel(int newLevel) {
        startingLevel = newLevel;
    }
    
    public int getStartingLevel() {
        return startingLevel;
    }
    
    public void resetBackground() {
        background = new Block[100][100];
        color[] colors = {color(0, 255, 255), color(50, 50, 255), color(255, 125, 0), color(245, 245, 0), color(25, 240, 25), color(125, 0, 255), color(255, 0, 0)};
        for (int r = 0; r < background.length; r++) {
            for (int c = 0; c < background[r].length; c++) {
                color clr = colors[(int)(Math.random() * 7)];
                background[r][c] = new Block(r, c, clr);
            }
        }
    }
    
    public void windowResized() {
        gameOver.windowResized();
        main.windowResized();
        pause.windowResized();
        settings.windowResized();
        selectStartingLevel.windowResized();
    }
    
    public void pause() {
        if (!(inGame || currentGUI.equals(pause)))
            exit();
        
        currentGUI = pause;
        
        inPause = !inPause;
        inGame = !inGame;
        
    }
    
    public boolean needToResetGame() {
        if (needToResetGame) {
            needToResetGame = false;
            return true;
        }
        return false;
    }
    
    public void gameOver() {
        inGame = false;
        currentGUI = gameOver;
    }
    
    public boolean inGame() {
        return inGame;
    }
    
    public boolean inPause() {
        if (currentGUI == null)
            return false;
        return currentGUI.equals(pause);
    }
    
    public void keyPressed() {
        currentGUI.keyPressed();
    }
    
    public void mousePressed() {
        currentGUI.mousePressed();
    }
    
    public void mouseReleased() {
        currentGUI.mouseReleased();
    }
}
