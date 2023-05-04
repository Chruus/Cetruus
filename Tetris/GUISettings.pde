public class GUISettings extends GUI{
    Button back;
    KeyBindings keyBinds;
    
    public GUISettings(int scale_, color textColor, color backgroundColor, KeyBindings keyBinds_) {
        super(scale_);
        keyBinds = keyBinds_;
        back = new Button("Back", textColor, 2 * scale, 1 * scale, 4 * scale, 2 * scale, backgroundColor);
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        back.display();
        
        popMatrix();
        popStyle();
        
    }
    
    public void mousePressed() {
        back.mousePressed();
    }
    
    public void mouseReleased() {
        back.mouseReleased();
    }
    
    public String goTo() {
        if (back.hasBeenPressed())
            return "main";
        return "";
    }
}