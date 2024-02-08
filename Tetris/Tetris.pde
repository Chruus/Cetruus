//Christopher Petty

import processing.sound.*;

void setup() {
    size(420, 600);
    frameRate(60);
    
    scale = 30;
    
    stats = new Stats();        
    file = new SaveFile();
    keyBinds = new KeyBindings();
    UI = new UserInterface(scale, stats);
    hold = new SoundFile(this, "hold.wav");
    music = new SoundFile(Tetris.this, "music.wav");
    font = createFont("tetris font.otf", scale);
    
    music.amp(0.25);
    
    textFont(font);
    resetGame();
}

Bag bag;
boolean canswapHeldTetromino;
Grid grid;
int scale, timeToMoveDown;
KeyBindings keyBinds;
PFont font;
SaveFile file;
SoundFile hold, music;
Stats stats;
Tetromino currentTetro, heldTetro;
UserInterface UI;

void draw() {
    if (!UI.inGame()) {
        UI.display();
        return;
    }
    
    if (UI.needToResetGame())
        resetGame();
    
    if (keyBinds.canRegisterKey())
        onInput();
    
    if (!music.isPlaying())
        music.play();
    
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
    
    hold.play();
    
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
    
    stats.reset();
    
    grid = new Grid(stats);
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
    
    System.out.println(currentTetro + " " +  grid);
    
    if (!currentTetro.canMove("down")) {
        UI.gameOver();
    }
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
    textSize(scale * 0.3);
    fill(255);
    
    int x = scale / 2 * 21;
    int y = scale * 17;
    
    text("Score:\n" + stats.score(), x, y - scale * 1.65);
    text("Lines:\n" + stats.lines(), x, y);
    text("Level:\n" + stats.level(), x, y + scale * 1.65);
    
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
        if (grid.canAddTetromino(currentTetro, getTimeToMoveDown()))
            addToGrid();
        return;
    }
    
    if (isTimeToMoveDown()) {
        currentTetro.move("down");
    }
}

public int getTimeToMoveDown() {
    int level = stats.level();
    
    if (level == 1)
        return 48;
    else if (level == 2)
        return 43;
    else if (level == 3)
        return 38;
    else if (level == 4)
        return 33;
    else if (level == 5)
        return 28;
    else if (level == 6)
        return 23;
    else if (level == 7)
        return 18;
    else if (level == 8)
        return 13;
    else if (level == 9)
        return 8;
    else if (level == 10)
        return 6;
    else if (level >= 11 && level <= 13)
        return 5;
    else if (level >= 14 && level <= 16)
        return 4;
    else if (level >= 17 && level <= 19)
        return 3;
    else if (level >= 20 && level <= 29)
        return 2;
    return 1;
}

private boolean isTimeToMoveDown() {
    if (timeToMoveDown > 0) {
        timeToMoveDown--;
        return false;
    }
    
    timeToMoveDown = getTimeToMoveDown();
    
    return true;
}

private void onInput() {
    if (keyBinds.getCurrentKey() == keyBinds.get("move left") && currentTetro.canMove("left")) {
        currentTetro.move("left");
    }
    if (keyBinds.getCurrentKey() == keyBinds.get("move right") && currentTetro.canMove("right")) {
        currentTetro.move("right");
    }
    if (keyBinds.getCurrentKey() == keyBinds.get("soft drop") && currentTetro.canMove("down")) {
        currentTetro.move("down");
        stats.setScore(stats.score() + 1);
    }
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
    keyBinds.keyPressed(keyCode);
    
    if (!UI.inGame())
        UI.keyPressed();
    
    if (keyCode == 27) {
        key = 0;
        UI.pause();
        
        if (music.isPlaying())
            music.pause();
        else
            music.play();
    }
    if (keyCode == BACKSPACE) {
        key = 27;
    }
    if (!UI.inGame())
        return;
    
    if (keyCode == keyBinds.get("hard drop") && currentTetro.canMove("down")) {
        stats.setScore(stats.score() + currentTetro.hardDrop());
        addToGrid();
    }
    if (keyCode == keyBinds.get("rotate left")) {
        currentTetro.rotate(false);
    }
    if (keyCode == keyBinds.get("rotate right")) {
        currentTetro.rotate(true);
    }
    if (keyCode == keyBinds.get("hold tetro")) {
        swapHeldTetromino();
    }
}

void keyReleased() {
    keyBinds.keyReleased(keyCode);
}
