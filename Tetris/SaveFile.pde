public class SaveFile{
    int hiScore, hiLines, hiLevel;
    
    public SaveFile() {
        String[] scores = loadStrings("scores.txt");
        
        if (scores == null) {
            scores = new String[3];
            scores[0] = scores[1] = scores[2] = "0";
            saveStrings("scores.txt", scores);
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
        
        stats.reset();
        updateStats();
    }
    
    public void updateStats() {
        String[] words = new String[3];
        words[0] = hiScore + "";
        words[1] = hiLines + "";
        words[2] = hiLevel + "";
        saveStrings("scores.txt", words);
    }
    
    public boolean loadKeyBinds(HashMap<String, Integer> keyBinds) {
        String[] keyBindsFile = loadStrings("keybinds.txt");
        
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
        
        saveStrings("keybinds.txt", words);
    }
    
    
    public int loadInitDelay() {
        String[] words = loadStrings("delays.txt");
        
        if (words == null) {
            words = new String[2];
            words[0] = "8";
            words[1] = "1";
            saveStrings("delays.txt", words);
            
            return 8;
        }
        
        return Integer.parseInt(words[0]);
    }
    
    public int loadDelay() {
        String[] words = loadStrings("delays.txt");
        
        if (words == null) {
            words = new String[2];
            words[0] = "8";
            words[1] = "1";
            saveStrings("delays.txt", words);
            
            return 1;
        }
        
        return Integer.parseInt(words[1]);
    }
    
    public void saveDelays() {
        String[] words = new String[2];
        int num = 0;
        
        words[0] = "" + keyBinds.initialKeyDelay();
        words[1] = "" + keyBinds.keyDelay();
        
        saveStrings("delays.txt", words);
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