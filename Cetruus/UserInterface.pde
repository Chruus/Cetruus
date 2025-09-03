import processing.sound.*;

public class UserInterface{
    Block[][] background;
    boolean needToResetGame, inGame, inPause;
    GUI currentGUI, gameOver, main, pause, settings, keyBinds, selectStartingLevel;
    int scale, startingLevel;
    Stats stats;
    
    public UserInterface(Stats stats_) {
        scale = Cetruus.scale;
        stats = stats_;
        
        color backgroundColor = color(225, 225, 255);
        color textColor = color(0);
        
        gameOver = new GUIGameOver(scale, textColor, backgroundColor, stats);
        main = new GUIMain(scale, textColor, backgroundColor);
        pause = new GUIPause(scale, textColor, backgroundColor);
        settings = new GUISettings(scale, textColor, backgroundColor);
        selectStartingLevel = new GuiStartingLevel(scale, textColor, backgroundColor);
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
        background(25);
        for (int r = 0; r < background.length; r++) {
            for (int c = 0; c < background[r].length; c++) {
                background[r][c].display();
            }
        }
        
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        fill(20, 230);
        rect(0, 0, 2000, 2000);
        
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
        background = new Block[20][15];
        color[] colors = {color(0, 255, 255), color(50, 50, 255), color(255, 125, 0), color(245, 245, 0), color(25, 240, 25), color(125, 0, 255), color(255, 0, 0)};
        for (int r = 0; r < background.length; r++) {
            for (int c = 0; c < background[r].length; c++) {
                color clr = colors[(int)(Math.random() * 7)];
                background[r][c] = new Block(r, c, scale, clr);
            }
        }
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