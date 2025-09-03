public class GUIPause extends GUI{
    Button resume, restart, quit;
    
    public GUIPause(color textColor, color backgroundColor) {
        int X = width / 2;
        int resumeY = height / 2 - Cetruus.scale;
        int restartY = height / 2 + 3 * Cetruus.scale;
        int quitY = height / 2 + 7 * Cetruus.scale;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        resume = new Button("Resume", textColor, X, resumeY, width, height, backgroundColor);
        restart = new Button("Restart", textColor, X, restartY, width, height, backgroundColor);
        quit = new Button("Quit", textColor, X, quitY, width, height, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        resume.display();
        restart.display();
        quit.display();
        
        textAlign(CENTER);
        textSize(Cetruus.scale * 2);
        fill(255);
        
        text("Paused", width / 2, height / 2 - Cetruus.scale * 5);
        
        popMatrix();
        popStyle();
    }
    
    public void windowResized() {
        int X = width / 2;
        int resumeY = height / 2 - Cetruus.scale;
        int restartY = height / 2 + 3 * Cetruus.scale;
        int quitY = height / 2 + 7 * Cetruus.scale;
        int width = 10 * Cetruus.scale;
        int height = 3 * Cetruus.scale;
        resume.resize(X, resumeY, width, height);
        restart.resize(X, restartY, width, height);
        quit.resize(X, quitY, width, height);
    }
    
    public void keyPressed() {}
    
    public void mousePressed() {
        resume.mousePressed();
        restart.mousePressed();
        quit.mousePressed();
    }
    
    public void mouseReleased() {
        resume.mouseReleased();
        restart.mouseReleased();
        quit.mouseReleased();
    }
    
    public String goTo() {
        if (resume.hasBeenPressed())
            return "game";
        if (restart.hasBeenPressed())
            return "new game";
        if (quit.hasBeenPressed())
            return "main";
        return "";
    }
}
