//Christopher Petty
import processing.sound.*;
//import processing.

void settings() {
    ratio = (int)(((float)displayWidth / (float)displayHeight) * 1000.0);
    
    //windowTitle("Cetruus");
    
    //16x10
    if (ratio == 1600) {
        size((int)(displayWidth * 420 / 1920),(int)(displayHeight * 600 / 1200));
        scale = Math.min(displayWidth / 64, displayHeight / 40);
    }
    //16x9
    else if (ratio == 1777) {
        size((int)(displayWidth * 420 / 1920),(int)(displayHeight * 600 / 1080));
        scale = Math.min(displayWidth / 64, displayHeight / 36);
    }
    //21x9
    else if (ratio == 2333) {
        size((int)(displayWidth * 420 / 2560),(int)(displayHeight * 600 / 1080));
        scale = Math.min((int)(displayWidth / (85 + 1 / 3)), displayHeight / 36);
    }
    else {
        size((int)(displayWidth / 4),(int)(displayHeight / 2));
        scale = Math.min(displayWidth / 64, displayHeight / 36);
    }
    
}

void setup() {
    surface.setResizable(true);
    frameRate(60);
    
    musicAmp = 1;
    soundAmp = 1;
    
    stats = new Stats();        
    file = new SaveFile();
    keyBinds = new KeyBindings();
    UI = new UserInterface(stats);
    hold = new SoundFile(Cetruus.this, "hold.wav", false);
    music = new SoundFile(this, "music.wav");
    drop = new SoundFile(Cetruus.this, "drop.wav");
    clear = new SoundFile(Cetruus.this, "clear.wav");
    clearTetris = new SoundFile(Cetruus.this, "clear tetris.wav");
    font = createFont("tetris font.otf", scale);
    
    muted = false;
    
    textFont(font);
    
    if (midGame()) {
        file.loadGame();
        UI.checkGoto("game");
        UI.pause();
        canswapHeldTetromino = true;
    }
    
    Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
        public void run() {
            if (UI.inGame() || UI.inPause())
                file.saveGame(grid, bag, stats, currentTetro, heldTetro);
        }
    }));
}

private int prevWidth, prevHeight;
public static Bag bag;
private boolean canswapHeldTetromino;
public static boolean muted;
public static Grid grid;
public static int scale;
public static float musicAmp, soundAmp;
private int ratio, timeToMoveDown;
public static KeyBindings keyBinds;
private PFont font;
public static SaveFile file;
public static SoundFile hold, music, drop, clear, clearTetris;
public static Stats stats;
public static Tetromino currentTetro, heldTetro;
public static UserInterface UI;

void draw() {
    if (prevWidth != width || prevHeight != height) {
        windowResized();
        prevWidth = width;
        prevHeight = height;
    }
    
    if (!UI.inGame()) {
        UI.display();
        return;
    }
    
    if (UI.needToResetGame())
        resetGameState();
    
    if (keyBinds.canRegisterKey())
        onInput();
    
    if (!music.isPlaying()) {
        music.stop();
        music.play();
        music.amp(musicAmp);
    }
    
    if (!focused && !UI.inPause())
        pause();
    
    calculateGravity();
    displayGame();
    displaycurrentTetro();
}

void windowResized() {    
    scale = Math.min(30 * width / 420, 30 * height / 600);
    UI.windowResized();
}

private boolean midGame() {
    String[] temp = loadStrings("data\\gameState.txt");
    if (temp == null || temp.length < 20)
        return false;
    return true;
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
    if (muted)
        displayMuted(scale * 13, scale * 19, scale * 2 / 3);
    grid.display();
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
    
    int x = (int)(width / 2 + scale * 3.5);
    int y = (int)(height / 2 + scale * 7);
    
    text("Score : \n" + stats.score(), x, y - scale * 1.65);
    text("Lines:\n" + stats.lines(), x, y);
    text("Level : \n" + stats.level(), x, y + scale * 1.65);
    
    popMatrix();
    popStyle();
}

public void displayGameBackground() {  
    background(0);
    
    pushStyle();
    pushMatrix();
    
    rectMode(CENTER);
    fill(25);
    rect(width / 2, height / 2, scale * 14, scale * 20);
    
    strokeWeight(2);
    stroke(20);
    fill(40);
    
    rect(360, 60, 118, 119, 5, 5, 5, 5);
    rect(360, 270, 118, 299, 5, 5, 5, 5);
    rect(360, 510, 118, 179, 5, 5, 5, 5);
    
    popMatrix();
    popStyle();
}

private void displayMuted(int x, int y, int size) {
    pushStyle();
    pushMatrix();
    
    rectMode(CENTER);
    ellipseMode(CENTER);
    strokeWeight(size / 25);
    stroke(255);
    fill(255);
    rect(x - size / 4, y, size / 2, size / 2);
    quad(x, y - size / 4, x + size / 2, y - size / 2, x + size / 2, y + size / 2, x, y + size / 4);
    strokeWeight(size / 10);
    stroke(255,0,0);
    fill(0, 0);
    ellipse(x, y, size * 1.5, size * 1.5);
    line(x - size / 2, y - size / 2, x + size / 2, y + size / 2);
    
    popMatrix();
    popStyle();
}

private void swapHeldTetromino() {
    if (!canswapHeldTetromino)
        return;
    
    hold.play();
    hold.amp(soundAmp);
    
    Tetromino oldheldTetro = heldTetro;
    heldTetro = currentTetro;
    canswapHeldTetromino = false;
    
    if (oldheldTetro == null)
        currentTetro = bag.getNextTetromino();
    else
        currentTetro = oldheldTetro;
    
    currentTetro.reset();
}

private void resetGameState() {
    canswapHeldTetromino = true;      
    
    file.resetGame();
    stats.reset();
    stats.setLevel(UI.getStartingLevel());
    
    grid = new Grid(stats);
    bag = new Bag(grid);
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
        UI.gameOver();
        music.stop();
        file.saveStats(stats);
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
    
    int x = (int)(width / 2 + scale * 3.5);
    int y = (int)(height / 2 + scale * 7);
    
    text("Score : \n" + stats.score(), x, y - scale * 1.65);
    text("Lines:\n" + stats.lines(), x, y);
    text("Level : \n" + stats.level(), x, y + scale * 1.65);
    
    popMatrix();
    popStyle();
}

public void displayGameBackground() {  
    background(0);
    
    pushStyle();
    pushMatrix();
    
    rectMode(CENTER);
    fill(25);
    rect(width / 2, height / 2, scale * 14, scale * 20);
    
    strokeWeight(2);
    stroke(20);
    fill(40);
    
    rect(width / 2 + scale * 5, height / 2 - scale * 8, scale * 4 - 2, scale * 4 - 1, 5, 5, 5, 5);
    rect(width / 2 + scale * 5, height / 2 - scale * 1, scale * 4 - 2, scale * 10 - 1, 5, 5, 5, 5);
    rect(width / 2 + scale * 5, height / 2 + scale * 7, scale * 4 - 2, scale * 6 - 1, 5, 5, 5, 5);
    
    popMatrix();
    popStyle();
}

private void displayMuted(int x, int y, int size) {
    pushStyle();
    pushMatrix();
    
    rectMode(CENTER);
    ellipseMode(CENTER);
    strokeWeight(size / 25);
    stroke(255);
    fill(255);
    rect(x - size / 4, y, size / 2, size / 2);
    quad(x, y - size / 4, x + size / 2, y - size / 2, x + size / 2, y + size / 2, x, y + size / 4);
    strokeWeight(size / 10);
    stroke(255,0,0);
    fill(0, 0);
    ellipse(x, y, size * 1.5, size * 1.5);
    line(x - size / 2, y - size / 2, x + size / 2, y + size / 2);
    
    popMatrix();
    popStyle();
}

private void swapHeldTetromino() {
    if (!canswapHeldTetromino)
        return;
    
    hold.play();
    hold.amp(soundAmp);
    
    Tetromino oldheldTetro = heldTetro;
    heldTetro = currentTetro;
    canswapHeldTetromino = false;
    
    if (oldheldTetro == null)
        currentTetro = bag.getNextTetromino();
    else
        currentTetro = oldheldTetro;
    
    currentTetro.reset();
}

private void resetGameState() {
    canswapHeldTetromino = true;      
    
    file.resetGame();
    stats.reset();
    stats.setLevel(UI.getStartingLevel());
    
    grid = new Grid(stats);
    bag = new Bag(grid);
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
        UI.gameOver();
        music.stop();
        file.saveStats(stats);
    }
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
        stats.setScore(stats.score() + stats.level());
    }
}

void pause() {
    print("test");
    if (music.isPlaying()) {
        music.pause();
        music.amp(0);
    }
    else{
        music.play();
        music.amp(musicAmp);
    }
    key = 0;
    UI.pause();
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
    
    if (key == 'm') {
        if (muted) {
            musicAmp = file.loadMusicVolume() / 100.0;
            soundAmp = file.loadSoundVolume() / 100.0;
            music.amp(musicAmp);
            hold.amp(soundAmp);
            drop.amp(soundAmp);
            clear.amp(soundAmp);
            clearTetris.amp(soundAmp);
        }
        else{
            musicAmp = 0;
            soundAmp = 0;
            music.amp(0);
            hold.amp(0);
            drop.amp(0);
            clear.amp(0);
            clearTetris.amp(0);
        }
        muted = !muted;
    }
    
    
    if (!UI.inGame())
        UI.keyPressed();
    
    if (keyCode == 27) {
        pause();
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
