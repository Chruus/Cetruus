public class Stats{
    private int score, lines, level, startLevel;
    private boolean hardLastClear;
    
    public Stats() {
        score = lines = 0;
        level = 1;
        startLevel = 1;
        hardLastClear = false;
    }
    
    public Stats(int score_, int lines_, int level_) {
        score = score_;
        lines = lines_;
        level = level_;
        startLevel = 1;
        hardLastClear = false;
    }
    
    public void set(int score_, int lines_, int level_) {
        score = score_;
        lines = lines_;
        level = level_;
    }
    
    public void setScore(int score_) {
        score = score_;
    }
    
    public void setLines(int lines_) {
        lines = lines_;
    }
    
    public void setLevel(int level_) {
        level = level_;
    }
    
    public void setStartingLevel(int level_) {
        startLevel = level_;
    }
    
    public void reset() {
        score = lines = 0;
        level = startLevel;
    }
    
    public void calculateScore(int numOfLinesCleared) {
        lines += numOfLinesCleared;
        double multiplier = 1;
        
        if (numOfLinesCleared < 4)
            hardLastClear = false;
        if (hardLastClear)
            multiplier = 1.5;
        
        if (numOfLinesCleared == 1) 
            score += 100 * level;
        if (numOfLinesCleared == 2) 
            score += 300 * level;
        if (numOfLinesCleared == 3)
            score += 500 * level;
        if (numOfLinesCleared == 4) {
            score += 800 * level * multiplier;
            hardLastClear = true;
        }
        
        if ((lines % 10) - numOfLinesCleared < 0)
            level++;
    }
    
    public int score() {
        return score;
    }
    
    public int lines() {
        return lines;
    }
    
    public int level() {
        return level;
    }
    
    public int getStartingLevel() {
        return startLevel;
    }
    
    public String toString() {
        return score + " " + lines + " " + level;
    }
}