public class SaveFile{
    int hiScore, hiLines, hiLevel;
    
    public SaveFile() {
        String[] scores = loadStrings("data\\hiScores.txt");
        
        if (scores == null) {
            scores = new String[3];
            scores[0] = scores[1] = scores[2] = "0";
            saveStrings("data\\hiScores.txt", scores);
        }
        
        hiScore = Integer.parseInt(scores[0]);
        hiLines = Integer.parseInt(scores[1]);
        hiLevel = Integer.parseInt(scores[2]);
    }
    
    public void saveStats(Stats stats) {
        
        if (stats.score() > hiScore)
            hiScore = stats.score();
        if (stats.lines() > hiLines)
            hiLines = stats.lines();
        if (stats.level() > hiLevel)
            hiLevel = stats.level();
        
        updateStats();
    }
    
    public void updateStats() {
        String[] words = new String[3];
        words[0] = hiScore + "";
        words[1] = hiLines + "";
        words[2] = hiLevel + "";
        saveStrings("data\\hiScores.txt", words);
    }
    
    public boolean loadKeyBinds(HashMap<String, Integer> keyBinds) {
        String[] keyBindsFile = loadStrings("data\\keybinds.txt");
        
        if (keyBindsFile == null)
            return false;
        
        for (int i = 0; i < keyBindsFile.length; i++) {
            String[] data = keyBindsFile[i].split(" - ");
            keyBinds.put(data[0], Integer.parseInt(data[1]));
        }
        
        return true;
    }
    
    public void saveKeyBinds(HashMap<String, Integer> keyBinds) {
        String[] words = new String[7];
        int num = 0;
        
        for (String key : keyBinds.keySet()) {
            words[num] = key + " - " + keyBinds.get(key);
            num++;
        }
        
        saveStrings("data\\keybinds.txt", words);
    }
    
    
    public int loadInitDelay() {
        String[] words = loadStrings("data\\delays.txt");
        
        if (words == null) {
            words = new String[2];
            words[0] = "8";
            words[1] = "1";
            saveStrings("data\\delays.txt", words);
            
            return 8;
        }
        
        return Integer.parseInt(words[0]);
    }
    
    public int loadDelay() {
        String[] words = loadStrings("data\\delays.txt");
        
        if (words == null) {
            words = new String[2];
            words[0] = "8";
            words[1] = "1";
            saveStrings("data\\delays.txt", words);
            
            return 1;
        }
        
        return Integer.parseInt(words[1]);
    }
    
    public void saveDelays() {
        String[] words = new String[2];
        int num = 0;
        
        words[0] = "" + keyBinds.initialKeyDelay();
        words[1] = "" + keyBinds.keyDelay();
        
        saveStrings("data\\delays.txt", words);
    }
    
    public void saveGame(Grid grid, Bag bag, Stats stats, Tetromino currentTetro, Tetromino heldTetro) {
        String[] data = new String[27];
        
        for (int r = 0; r < 20; r++) {
            for (int c = 0; c < 10; c++) {
                if (data[r] == null)
                    data[r] = "";
                if (grid.getBlock(r, c) == null)
                    data[r] += "none ";
                else
                    data[r] += grid.getBlock(r, c).toString() + " ";
            }
        }
        
        if (bag.main.size() == 0)
            bag.reserveToMain();
        data[20] = bag.main.toString().substring(1, bag.main.toString().length() - 1);
        data[21] = bag.reserve.toString().substring(1, bag.reserve.toString().length() - 1);
        
        data[22] = "" + stats.score();
        data[23] = "" + stats.lines();
        data[24] = "" + stats.level();
        
        data[25] = currentTetro.toString().substring(0, 10) + " " + currentTetro.row() + " " + currentTetro.col() + " " + currentTetro.rotation();
        if (heldTetro != null)
            data[26] = heldTetro.toString().substring(0, 10) + " " + heldTetro.row() + " " + heldTetro.col() + " " + heldTetro.rotation();
        
        saveStrings("data\\gameState.txt", data);
    }
    
    public void loadGame() {
        String[] data = loadStrings("data\\gameState.txt");
        
        stats = new Stats(Integer.parseInt(data[22]), Integer.parseInt(data[23]), Integer.parseInt(data[24]));
        grid = new Grid(stats);
        bag = new Bag(scale, grid);
        UI = new UserInterface(scale, stats);
        
        for (int r = 0; r < 20; r++) {
            String[] blocks = data[r].split(" ");
            for (int c = 0; c < 10; c++) {
                if (blocks[c].equals("none"))
                    continue;
                Block temp = new Block(r, c, scale, color(Integer.parseInt(blocks[c])));
                grid.setBlock(temp, r, c);
            }
        }
        
        bag.main = new ArrayList<Tetromino>();
        
        for (String str : data[20].split(", ")) {
            String[] temp = str.split(" ");
            bag.main.add(getTetro(temp[0], Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), grid, Integer.parseInt(temp[3])));
        }
        
        bag.reserve = new ArrayList<Tetromino>();
        for (String str : data[21].split(", ")) {
            String[] temp = str.split(" ");
            bag.reserve.add(getTetro(temp[0], Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), grid, Integer.parseInt(temp[3])));
        }
        
        String[] temp = data[25].split(" ");
        currentTetro = getTetro(temp[0], Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), grid, Integer.parseInt(temp[3]));
        
        if (data[26].equals("null")) {
            resetGame();
            return;
        }
        temp = data[26].split(" ");
        heldTetro = getTetro(temp[0], Integer.parseInt(temp[1]), Integer.parseInt(temp[2]), grid, Integer.parseInt(temp[3]));
        
        resetGame();
    }
    
    public void resetGame() {
        String[] temp = new String[1];
        temp[0] = " ";
        
        saveStrings("data\\gameState.txt", temp);
    }
    
    public Tetromino getTetro(String name, int row, int col, Grid grid, int rotation) {
        Tetromino output = null;
        
        switch(name) {
            case "TetrominoI":
                output = new TetrominoI(row, col, scale, grid, rotation);
                break;
            case "TetrominoJ":
                output = new TetrominoJ(row, col, scale, grid, rotation);
                break;
            case "TetrominoL":
                output = new TetrominoL(row, col, scale, grid, rotation);
                break;
            case "TetrominoO":
                output = new TetrominoO(row, col, scale, grid, rotation);
                break;
            case "TetrominoS":
                output = new TetrominoS(row, col, scale, grid, rotation);
                break;
            case "TetrominoT":
                output = new TetrominoT(row, col, scale, grid, rotation);
                break;
            case "TetrominoZ":
                output = new TetrominoZ(row, col, scale, grid, rotation);
                break;
        }
        
        return output;
    }
    
    public int hiScore() {
        return hiScore;
    }
    
    public int hiLines() {
        return hiLines;
    }
    
    public int hiLevel() {
        return hiLevel;
    }
}