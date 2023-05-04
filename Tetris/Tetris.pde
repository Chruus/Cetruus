//Christopher Petty
void setup() {
    size(420, 600);
    resetGame();
    scale = 30;
    UI = new UserInterface(scale);
}

Bag bag;
boolean canswapHeldTetromino, isAlive;
Grid grid;
int level, score, linesCleared;
int scale, timeToMoveDown;
Tetromino currentTetro, heldTetro;
UserInterface UI;

void draw() {
    if (!UI.inGame()) {
        UI.display();
        return;
    }
    
    if (UI.needToResetGame())
        resetGame();
    
    calculateGravity();
    displayGame();
    displaycurrentTetro();
}

private void displaycurrentTetro() {
    currentTetro.displayGhost();
    currentTetro.display();
}

private void displayGame() {
    displayGameBackground();
    displayCurrentStats();
    displayFutureTetrominos();
    displayHeldTetromino();
    grid.display();
}

private void swapHeldTetromino() {
    if (!canswapHeldTetromino)
        return;
    
    Tetromino oldheldTetro = heldTetro;
    heldTetro = currentTetro;
    canswapHeldTetromino = false;
    
    if (oldheldTetro == null)
        currentTetro = bag.getNextTetromino();
    else
        currentTetro = oldheldTetro;
    
    currentTetro.reset();
}

private void resetGame() {
    canswapHeldTetromino = true;
    isAlive = false;
    
    level = 1;
    linesCleared = 0;
    score = 0;
    
    grid = new Grid();
    bag = new Bag(scale, grid);
    currentTetro = bag.getNextTetromino();
    heldTetro = null;
}

private void addToGrid() {
    currentTetro.addToGrid();
    currentTetro.reset();
    currentTetro = bag.getNextTetromino();
    currentTetro.reset();
    grid.clearFullRows();
    canswapHeldTetromino = true;
    
    if (!currentTetro.canMove("down")) {
        isAlive = false;
        UI.gameOver();
    }
}

private void calculateScore(int numOfLinesCleared) {
    if (numOfLinesCleared == 1) {
        linesCleared += 1;
        score += 100 * level;
    } else if (numOfLinesCleared == 2) {
        linesCleared += 2;
        score += 300 * level;
    } else if (numOfLinesCleared == 3) {
        linesCleared += 3;
        score += 500 * level;
    } else if (numOfLinesCleared == 4) {
        linesCleared += 4;
        score += 800 * level;
    }
    level = linesCleared / 10 + 1;
}


private void displayHeldTetromino() {
    if (heldTetro == null)
        return;
    heldTetro.reset();
    heldTetro.setPos(2, 12);
    heldTetro.display();
}

private void displayFutureTetrominos() {
    ArrayList<Tetromino> tetros = bag.getFutureTetrominos();
    tetros.get(0).setPos(6, 12);
    tetros.get(1).setPos(9, 12);
    tetros.get(2).setPos(12, 12);
    for (Tetromino tetro : tetros) {
        tetro.display();
    }
}

private void displayCurrentStats() {
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

public void displayGameBackground() {  
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

private void calculateGravity() {
    if (!currentTetro.canMove("down")) {
        if (grid.canAddTetromino(currentTetro))
            addToGrid();
        return;
    }
    
    if (isTimeToMoveDown()) {
        currentTetro.move("down");
    }
}

private boolean isTimeToMoveDown() {
    if (timeToMoveDown > 0) {
        timeToMoveDown--;
        return false;
    }
    
    if (level == 1)
        timeToMoveDown = 48;
    else if (level == 2)
        timeToMoveDown = 43;
    else if (level == 3)
        timeToMoveDown = 38;
    else if (level == 4)
        timeToMoveDown = 33;
    else if (level == 5)
        timeToMoveDown = 28;
    else if (level == 6)
        timeToMoveDown = 23;
    else if (level == 7)
        timeToMoveDown = 18;
    else if (level == 8)
        timeToMoveDown = 13;
    else if (level == 9)
        timeToMoveDown = 8;
    else if (level == 10)
        timeToMoveDown = 6;
    else if (level >= 11 && level <= 13)
        timeToMoveDown = 5;
    else if (level >= 14 && level <= 16)
        timeToMoveDown = 4;
    else if (level >= 17 && level <= 19)
        timeToMoveDown = 3;
    else if (level >= 20 && level <= 29)
        timeToMoveDown = 2;
    else if (level >= 30)
        timeToMoveDown = 1;
    
    return true;
}

void mousePressed() {
    if (!UI.inGame())
        UI.mousePressed();
}

void mouseReleased() {
    if (!UI.inGame())
        UI.mouseReleased();
}

void keyPressed() {
    if (keyCode == 27) {
        key = 0;
        UI.pause();
    }
    if (keyCode == BACKSPACE) {
        key = 27;
    }
    if (key == ' ') {
        score += currentTetro.hardDrop();
        addToGrid();
    }
    if (key == 'c') {
        swapHeldTetromino();
    }
    if (key == 'z') {
        currentTetro.rotate(false);
    }
    if (keyCode == UP) {
        currentTetro.rotate(true);
    }
    if (keyCode == RIGHT && currentTetro.canMove("right")) {
        currentTetro.move("right");
    }
    if (keyCode == LEFT && currentTetro.canMove("left")) {
        currentTetro.move("left");
    }    
    if (keyCode == DOWN && currentTetro.canMove("down")) {
        currentTetro.move("down");
        score++;
    }
}