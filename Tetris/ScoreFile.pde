public class ScoreFile{
    int hiScore, hiLines, hiLevel;
    
    public ScoreFile(){
        String[] words = loadStrings("scores.txt");
        if(words.length > 0){
            hiScore = Integer.parseInt(words[0]);
            hiLines = Integer.parseInt(words[1]);
            hiLevel = Integer.parseInt(words[2]);
        }
    }

    public void saveScores(int score, int lines, int level){
        if(score > hiScore)
            hiScore = score;
        if(lines > hiLines)
            hiLines = lines;
        if(level > hiLevel)
            hiLevel = level;
        updateFile();
    }

    public void updateFile(){
        String[] words = new String[3];
        words[0] = hiScore + "";
        words[1] = hiLines + "";
        words[2] = hiLevel + "";
        saveStrings("scores.txt", words);

    }

    public int hiScore(){
        return hiScore;
    }

    public int hiLines(){
        return hiLines;
    }

    public int hiLevel(){
        return hiLevel;
    }
}