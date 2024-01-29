public abstract class GUI{
    private int scale;
    
    public GUI(int scale_) {
        scale = scale_;
    }
    
    public abstract void display();
    
    public abstract void mousePressed();
    
    public abstract void mouseReleased();
    
    public abstract void keyPressed();
    
    public abstract String goTo();
}