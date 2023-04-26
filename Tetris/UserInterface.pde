public class UserInterface{
    int scale;
    boolean hasChangedMenu, needToResetGame;
    boolean inMenu, inGame, inGameOver, inPause;
    Button returnToMenu, playAgain, play, resume, restart, quit;
    ScoreFile file;
    Block[][] background;
    public UserInterface(int scale_){
        scale = scale_;
        
        color backgroundColor = color(225, 225, 255);
        color textColor = color(0);

        inMenu = true;
        inGame = inGameOver = false;

        file = new ScoreFile();
        play = new Button("Play", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
        playAgain = new Button("Play Again", textColor, width / 2, (int)(16.5 * scale), 5 * scale, 2 * scale, backgroundColor);
        returnToMenu = new Button("Return to Menu", textColor, width / 2, (int)(13.5 * scale), 5 * scale, 2 * scale, backgroundColor);
        resume = new Button("Resume", textColor, width / 2, 9 * scale, 10 * scale, 3 * scale, backgroundColor);
        restart = new Button("Restart", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        quit = new Button("Quit", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);

        resetBackground();
    }

    public void displayHeldPiece(Tetromino piece){
        if(piece == null)
            return;
        Tetromino heldPiece = piece.clone();
        heldPiece.reset();
        heldPiece.setPos(2, 12);
        heldPiece.display();
    }

    public void displayFuturePieces(ArrayList<Tetromino> pieces){
        pieces.get(0).setPos(6, 12);
        pieces.get(1).setPos(9, 12);
        pieces.get(2).setPos(12, 12);
        for(Tetromino piece : pieces){
            piece.display();
        }
    }

    public boolean hasBeenPressed(){
        if(resume.hasBeenPressed()){
            inGame = true;
            inGameOver = inMenu = inPause = false;
            resetBackground();
            return true;
        }
        if((play.hasBeenPressed() || playAgain.hasBeenPressed() || restart.hasBeenPressed())){
            inGame = needToResetGame = true;
            inGameOver = inMenu = inPause = false;
            file.saveScores(score, linesCleared, level);
            resetBackground();
            return true;
        }
        if(returnToMenu.hasBeenPressed() || quit.hasBeenPressed()){
            inMenu = true;
            inGameOver = inGame = inPause = false;
            file.saveScores(score, linesCleared, level);
            resetBackground();
            return true;
        }
        return false;
    }

    public boolean needToResetGame(){
        if(needToResetGame){
            needToResetGame = false;
            return true;
        }
        return false;
    }

    public void displayMenu(){
        pushStyle();
        pushMatrix();
        
        displayBackground();
        play.display();
    
        textAlign(CENTER);
        fill(255);
        textSize(scale * 3);

        text("Tetris", width / 2, 4 * scale);

        textSize(scale);
        
        text("Highest Score:\n" + file.hiScore(), width / 2, 7 * scale);
        text("Highest Lines:\n" + file.hiLines(), width / 2, 10 * scale);
        text("Highest Level:\n" + file.hiLevel(), width / 2, 13 * scale);

        popMatrix();
        popStyle();

        hasBeenPressed();
    }

    public void pause(){
        inPause = !inPause;
    }

    public boolean isInGame(){
        return inGame;
    }

    public void gameOver(){
        inGameOver = true;
        inMenu = inGame = false;
    }

    public boolean isInPause(){
        return inPause;
    }

    public boolean isInGameOver(){
        return inGameOver;
    }

    public boolean isInMenu(){
        return inMenu;
    }

    public void displayPause(){
        pushStyle();
        pushMatrix();
        
        displayBackground();
        resume.display();
        restart.display();
        quit.display();

        textAlign(CENTER);
        textSize(scale * 3);
        fill(255);
        
        text("Paused", width / 2, 5 * scale);

        popMatrix();
        popStyle();
        
        hasBeenPressed();
    }

    public void displayGameOver(int score, int linesCleared, int level){
        inGameOver = true;
        inGame = inMenu = false;
        file.saveScores(score, linesCleared, level);

        pushStyle();
        pushMatrix();

        displayBackground();
        playAgain.display();
        returnToMenu.display();
    
        textAlign(CENTER);
        textSize(scale);
        fill(255);
        
        text("Score:", width / 2, 3 * scale);
        text(score, width / 2, 4.25 * scale);
        text("Lines:", width / 2, 6 * scale);
        text(linesCleared, width / 2, 7.25 * scale);
        text("Level:", width / 2, 9 * scale);
        text(level, width / 2, 10.25 * scale);

        popMatrix();
        popStyle();

        hasBeenPressed();
    }

    public void displayCurrentStats(int score, int linesCleared, int level){
        pushStyle();
        pushMatrix();
        
        textAlign(LEFT);
        textSize(scale * 0.5);
        fill(255);

        int x = scale / 2 * 21;
        int y = scale * 17;
        
        text("Score:\n" + score, x, y - scale * 1.65);
        text("Lines:\n" + linesCleared, x, y);
        text("Level:\n" + level, x, y + scale * 1.65);

        popMatrix();
        popStyle();
    }

    public void displayGameBackground(){  
        background(25);

        pushStyle();
        pushMatrix();

        rectMode(CENTER);
        strokeWeight(2);
        stroke(20);
        fill(40);
        
        rect(360, 60, 118, 119, 5, 5, 5, 5);
        rect(360, 270, 118, 299, 5, 5, 5, 5);
        rect(360, 510, 118, 179, 5, 5, 5, 5);

        popMatrix();
        popStyle();
    }

    public void resetBackground(){
        background = new Block[20][15];
        color[] colors = {color(0, 255, 255), color(50, 50, 255), color(255, 125, 0), color(245, 245, 0), color(25, 240, 25), color(125, 0, 255), color(255, 0, 0)};
        for(int r = 0; r < background.length; r++){
            for(int c = 0; c < background[r].length; c++){
                color clr = colors[(int)(Math.random() * 7)];
                background[r][c] = new Block(r, c, scale, clr);
            }
        }
    }

    public void displayBackground(){
        background(25);
        for(int r = 0; r < background.length; r++){
            for(int c = 0; c < background[r].length; c++){
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

    public void mousePressed(){
        if(inMenu){
            play.mousePressed();
        }
        if(inGameOver){
            playAgain.mousePressed();
            returnToMenu.mousePressed();
        }
        if(inPause){
            resume.mousePressed();
            restart.mousePressed();
            quit.mousePressed();
        }
    }

    public void mouseReleased(){
        if(inMenu)
            play.mouseReleased();
        if(inGameOver){
            playAgain.mouseReleased();
            returnToMenu.mouseReleased();
        }
        if(inPause){
            resume.mouseReleased();
            restart.mouseReleased();
            quit.mouseReleased();
        }
    }

}