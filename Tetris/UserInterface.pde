public class UserInterface{
    Block[][] background;
    boolean needToResetGame, inGame, inPause;
    GUI currentGUI, gameOver, main, pause, scores, settings;
    int scale;
    SaveFile file;
    Stats stats;
    
    public UserInterface(int scale_, KeyBindings keyBinds, Stats stats_) {
        scale = scale_;
        stats = stats_;
        
        color backgroundColor = color(225, 225, 255);
        color textColor = color(0);
        
        file = new SaveFile();
        gameOver = new GUIGameOver(scale, textColor, backgroundColor, stats);
        main = new GUIMain(scale, textColor, backgroundColor);
        pause = new GUIPause(scale, textColor, backgroundColor);
        scores = new GUIScores(scale, textColor, backgroundColor, file);
        settings = new GUISettings(scale, textColor, backgroundColor, keyBinds);
        currentGUI = main;
        
        resetBackground();
    }
    
    public void display() {
        displayBackground();
        currentGUI.display();
        checkGoto();
    }
    
    private void checkGoto() {
        String goTo = currentGUI.goTo();
        
        if (goTo.equals(""))
            return;
        if (currentGUI.equals(gameOver))
            file.saveStats(stats);
        if (goTo.equals("main")) 
            currentGUI = main;
        if (goTo.equals("scores"))
            currentGUI = scores;
        if (goTo.equals("settings"))
            currentGUI = settings;
        if (goTo.equals("game")) {
            currentGUI = null;
            inGame = true;
        }
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
        
        inPause = !inPause;
        inGame = !inGame;
        currentGUI = pause;
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
    
    public void mousePressed() {
        currentGUI.mousePressed();
    }
    
    public void mouseReleased() {
        currentGUI.mouseReleased();
    }
}