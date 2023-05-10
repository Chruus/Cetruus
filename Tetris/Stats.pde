public class Stats{
    private int score, lines, level;
    private boolean hardLastClear;
    
    public Stats() {
        score = lines = 0;
        level = 1;
        hardLastClear = false;
    }
    
    public Stats(int score_, int lines_, int level_) {
        score = score_;
        lines = lines_;
        level = level_;
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
    
    public void reset() {
        score = lines = 0;
        level = 1;
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
        
        level = lines / 10 + 1;
    }
    
    public int getTimeToMoveDown() {
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
    
    public int score() {
        return score;
    }
    
    public int lines() {
        return lines;
    }
    
    public int level() {
        return level;
    }
}