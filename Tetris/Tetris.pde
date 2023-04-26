//Christopher Petty
void setup() {
    size(420, 600);
    resetGame();
    scale = 30;
    UI = new UserInterface(scale);
}

Bag bag;
UserInterface UI;
Tetromino currentPiece, heldPiece;
Grid grid;
int level, score, linesCleared;
int scale, timeToMoveDown;
boolean canSwapHeldPiece, isAlive;

void draw() {
    if(isInMenu())
        return;
    if(UI.needToResetGame())
        resetGame();

    calculateGravity();
    displayGame();
    displayCurrentPiece();
}

private boolean isInMenu(){
    if(UI.isInGameOver()){
        UI.displayGameOver(score, linesCleared, level);
        return true;
    }
    
    if(UI.isInMenu()){
        UI.displayMenu();
        return true;
    }

    if(UI.isInPause()){
        UI.displayPause();
        return true;
    }

    return false;
}

private void displayCurrentPiece(){
    currentPiece.displayGhost();
    currentPiece.display();
}

private void displayGame(){
    UI.displayGameBackground();
    UI.displayCurrentStats(score, linesCleared, level);
    UI.displayFuturePieces(bag.getFuturePieces());
    UI.displayHeldPiece(heldPiece);
    grid.display();
}

private void swapHeldPiece(){
    if(!canSwapHeldPiece)
        return;
    
    Tetromino oldHeldPiece = heldPiece;
    heldPiece = currentPiece;
    canSwapHeldPiece = false;

    if(oldHeldPiece == null)
        currentPiece = bag.getNextPiece();
    else
        currentPiece = oldHeldPiece;
    
    currentPiece.reset();
}

private void resetGame(){
    canSwapHeldPiece = true;
    isAlive = false;
    
    level = 1;
    linesCleared = 0;
    score = 0;
    
    grid = new Grid();
    bag = new Bag(scale, grid);
    currentPiece = bag.getNextPiece();
    heldPiece = null;
}

private void addToGrid(){
    currentPiece.addToGrid();
    currentPiece.reset();
    currentPiece = bag.getNextPiece();
    currentPiece.reset();
    grid.clearFullRows();
    canSwapHeldPiece = true;

    if(!currentPiece.canMove("down")){
        isAlive = false;
        UI.gameOver();
    }
}

private void calculateScore(int numOfLinesCleared){
    if(numOfLinesCleared == 1){
        linesCleared += 1;
        score += 100 * level;
    } else if(numOfLinesCleared == 2){
        linesCleared += 2;
        score += 300 * level;
    } else if(numOfLinesCleared == 3){
        linesCleared += 3;
        score += 500 * level;
    } else if(numOfLinesCleared == 4){
        linesCleared += 4;
        score += 800 * level;
    }
    level = linesCleared / 10 + 1;
}

void mousePressed(){
    UI.mousePressed();
}

void mouseReleased(){
    UI.mouseReleased();
}

void keyPressed() {
    if(keyCode == 27 && UI.isInGame()){
        key = 0;
        UI.pause();
    }
    if(keyCode == BACKSPACE){
        key = 27;
    }
    if(key == ' '){
        score += currentPiece.hardDrop();
        addToGrid();
    }
    if(key == 'c'){
        swapHeldPiece();
    }
    if(key == 'z'){
        currentPiece.rotate(false);
    }
    if(keyCode == UP){
        currentPiece.rotate(true);
    }
    if(keyCode == RIGHT && currentPiece.canMove("right")){
        currentPiece.move("right");
    }
    if(keyCode == LEFT && currentPiece.canMove("left")){
        currentPiece.move("left");
    }    
    if(keyCode == DOWN && currentPiece.canMove("down")){
        currentPiece.move("down");
        score++;
    }
}

private void calculateGravity(){
    if(!currentPiece.canMove("down")){
        if(grid.canAddTetromino(currentPiece))
            addToGrid();
        return;
    }

    if(isTimeToMoveDown()){
        currentPiece.move("down");
    }
}

private boolean isTimeToMoveDown(){
    if(timeToMoveDown > 0){
        timeToMoveDown--;
        return false;
    }

    if(level == 1)
        timeToMoveDown = 48;
    else if(level == 2)
        timeToMoveDown = 43;
    else if(level == 3)
        timeToMoveDown = 38;
    else if(level == 4)
        timeToMoveDown = 33;
    else if(level == 5)
        timeToMoveDown = 28;
    else if(level == 6)
        timeToMoveDown = 23;
    else if(level == 7)
        timeToMoveDown = 18;
    else if(level == 8)
        timeToMoveDown = 13;
    else if(level == 9)
        timeToMoveDown = 8;
    else if(level == 10)
        timeToMoveDown = 6;
    else if(level >= 11 && level <= 13)
        timeToMoveDown = 5;
    else if(level >= 14 && level <= 16)
        timeToMoveDown = 4;
    else if(level >= 17 && level <= 19)
        timeToMoveDown = 3;
    else if(level >= 20 && level <= 29)
        timeToMoveDown = 2;
    else if(level >= 30)
        timeToMoveDown = 1;
    
    return true;
}