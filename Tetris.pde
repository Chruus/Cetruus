//Christopher Petty
void setup() {
    size(420, 600);

    addToGridDelay = 30;
    scale = 30;
    level = 1;
    linesCleared = 0;
    score = 0;

    canSwapHeldPiece = true;
    isAlive = false;
    
    grid = new Block[20][10];
    bag = new Bag(scale, grid);
    UI = new UserInterface(scale);
    currentPiece = bag.getNextPiece();
}

Bag bag;
UserInterface UI;
int level, score, linesCleared;
int scale, addToGridDelay;
Block[][] grid;
boolean canSwapHeldPiece, isAlive;
Tetromino currentPiece, heldPiece;

void draw() {
    if(!isAlive){
        UI.displayMenu();
        return;
    }
    drawBackground();
    displayGrid();
    UI.displayCurrentStats(score, linesCleared, level);
    UI.displayFuturePieces(bag.getFuturePieces());
    UI.displayHeldPiece(heldPiece);
    gravity();
    currentPiece.displayGhost();
    currentPiece.display();
}

private void swapHeldPiece(){
    if(!canSwapHeldPiece)
        return;
    
    canSwapHeldPiece = false;
    Tetromino oldHeldPiece = heldPiece;
    heldPiece = currentPiece;

    if(oldHeldPiece == null){
        currentPiece = bag.getNextPiece();
        canSwapHeldPiece = false;
        currentPiece.reset();
        return;
    }

    currentPiece = oldHeldPiece;
    currentPiece.reset();
}

private void drawBackground(){
    pushMatrix();
    pushStyle();

    background(30, 30, 40);
    strokeWeight(2);
    stroke(15, 15, 20);
    for(int x = 0; x <= scale * 10; x += scale){
        line(x, 0, x, scale * 20);
    }
    for(int y = 0; y <= scale * 20; y += scale){
        line(0, y, scale * 10, y);
    }

    popStyle();
    popMatrix();
}

private void displayGrid(){
    clearFullRows();
    for(int r = 0; r < grid.length; r++){
        for(int c = 0; c < grid[r].length; c++){
            if(grid[r][c] != null)
                grid[r][c].display();
        }
    }
}

private ArrayList<Integer> getFullRows(){
    ArrayList<Integer> fullRows = new ArrayList<Integer>();
    for(int r = 0; r < grid.length; r++){
        boolean isFullRow = true;
        for(int c = 0; c < grid[r].length; c++){
            if(grid[r][c] == null){
                isFullRow = false;
                break;
            }
        }
        if(isFullRow){
            fullRows.add(r);
        }
    }
    return fullRows;
}

private void clearFullRows(){
    ArrayList<Integer> fullRows = getFullRows();
    if(fullRows.size() == 0)
        return;
    
    for(int row : fullRows){
        shiftGridDown(row);
    }
    
    calculateScore(fullRows.size());
}

private void gameOver(){
    addToGridDelay = 30;
    scale = 30;
    level = 1;
    linesCleared = 0;
    score = 0;

    canSwapHeldPiece = true;
    isAlive = false;
    
    grid = new Block[20][10];
    bag = new Bag(scale, grid);
    UI = new UserInterface(scale);
    currentPiece = bag.getNextPiece();

    UI.displayGameOver();
}

private void addToGrid(){
    if(addToGridDelay > 0){
        addToGridDelay--;
        return;
    }
    currentPiece.addToGrid();
    currentPiece = bag.getNextPiece();
    currentPiece.reset();
    canSwapHeldPiece = true;
    addToGridDelay = 30;
    if(!currentPiece.canMove("down"))
        gameOver();
}


//For Testing
private void printGrid(){
    for(int r = 0; r < grid.length; r++){
        for(int c = 0; c < grid[r].length; c++){
            System.out.print('[');
            if(grid[r][c] != null)
                System.out.print(r);
            System.out.print(']');
        }
        System.out.println();
    }
}

private void shiftGridDown(int row){
    for(int r = row; r > 0; r--){
        for(int c = 0; c < grid[r].length; c++){
            grid[r][c] = grid[r - 1][c];
            if(grid[r][c] != null)
                grid[r][c].setPos(r, c);
        }
    }
    for(int c = 0; c < grid[0].length; c++){
        grid[0][c] = null;
    }
}

private void calculateScore(int numOfLinesCleared){
    if(numOfLinesCleared == 1){
        linesCleared += 1;
        score += 100 * level;
    } else if(numOfLinesCleared == 2){
        linesCleared += 2;
        score += 200 * level;
    } else if(numOfLinesCleared == 3){
        linesCleared += 3;
        score += 400 * level;
    } else if(numOfLinesCleared == 4){
        linesCleared += 4;
        score += 800 * level;
    }
    level = linesCleared / 10 + 1;
}

void keyPressed() {
    if(key == ' '){
        currentPiece.hardDrop();
        addToGridDelay = 0;
    }
    if(key == 'c'){
        swapHeldPiece();
    }
    if(key == 'z'){
        currentPiece.rotate(false);
    }
    if(key == CODED){
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
        }
    }
}

private void gravity(){
    if(!currentPiece.canMove("down")){
        addToGrid();
    }

    if(level == 1 && frameCount % 48 == 0){
        currentPiece.move("down");
    }
    if(level == 2 && frameCount % 43 == 0){
        currentPiece.move("down");
    }
    if(level == 3 && frameCount % 38 == 0){
        currentPiece.move("down");
    }
    if(level == 4 && frameCount % 33 == 0){
        currentPiece.move("down");
    }
    if(level == 5 && frameCount % 28 == 0){
        currentPiece.move("down");
    }
    if(level == 6 && frameCount % 23 == 0){
        currentPiece.move("down");
    }
    if(level == 7 && frameCount % 18 == 0){
        currentPiece.move("down");
    }
    if(level == 8 && frameCount % 13 == 0){
        currentPiece.move("down");
    }
    if(level == 9 && frameCount % 8 == 0){
        currentPiece.move("down");
    }
    if(level == 10 && frameCount % 6 == 0){
        currentPiece.move("down");
    }
    if(level >= 11 && level <= 13 && frameCount % 5 == 0){
        currentPiece.move("down");
    }
    if(level >= 14 && level <= 16 && frameCount % 4 == 0){
        currentPiece.move("down");
    }
    if(level >= 17 && level <= 19 && frameCount % 3 == 0){
        currentPiece.move("down");
    }
    if(level >= 20 && level <= 29 && frameCount % 2 == 0){
        currentPiece.move("down");
    }
    if(level >= 30 && frameCount % 1 == 0){
        currentPiece.move("down");
    }
}