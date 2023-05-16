public class SaveFile{
    int hiScore, hiLines, hiLevel;
    
    public SaveFile() {
        String[] words = loadStrings("scores.txt");
        if (words.length > 0) {
            hiScore = Integer.parseInt(words[0]);
            hiLines = Integer.parseInt(words[1]);
            hiLevel = Integer.parseInt(words[2]);
        }
    }
    
    public void saveStats(Stats stats) {
        if (stats.score() > hiScore)
            hiScore = stats.score();
        if (stats.lines() > hiLines)
            hiLines = stats.lines();
        if (stats.level() > hiLevel)
            hiLevel = stats.level();
        
        stats.reset();
        updateFile();
    }
    
    public void updateFile() {
        String[] words = new String[3];
        words[0] = hiScore + "";
        words[1] = hiLines + "";
        words[2] = hiLevel + "";
        saveStrings("scores.txt", words);
        
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