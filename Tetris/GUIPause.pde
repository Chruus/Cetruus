public class GUIPause extends GUI{
    Button resume, restart, quit;
    
    public GUIPause(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        resume = new Button("Resume", textColor, width / 2, 9 * scale, 10 * scale, 3 * scale, backgroundColor);
        restart = new Button("Restart", textColor, width / 2, 13 * scale, 10 * scale, 3 * scale, backgroundColor);
        quit = new Button("Quit", textColor, width / 2, 17 * scale, 10 * scale, 3 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        resume.display();
        restart.display();
        quit.display();
        
        textAlign(CENTER);
        textSize(scale * 3);
        fill(255);
        
        text("Paused", width / 2, 5 * scale);
        
        popMatrix();
        popStyle();
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
