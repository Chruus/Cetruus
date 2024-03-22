public class GUISettings extends GUI{
    GUI keyBindings, misc, video, currentGUI;
    Button toKeyBindings, toMisc, back;
    
    public GUISettings(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        misc = new GUISettingsMisc(scale_ ,textColor, backgroundColor);
        currentGUI = misc;
        
        keyBindings = new GUISettingsKeyBindings(scale_, textColor, backgroundColor);
        
        back = new Button("Back", textColor,(int)(2 * scale),(int)(1.5 * scale), 3 * scale, 2 * scale, backgroundColor);
        toMisc = new Button("Delay", textColor,(int)(6.25 * scale),(int)(1.5 * scale),(int)(3.5 * scale), 2 * scale, backgroundColor);
        toKeyBindings = new Button("Key Bind", textColor,(int)(10.75 * scale),(int)(1.5 * scale),(int)(5.5 * scale), 2 * scale, backgroundColor);
    }
    
    public void display() {
        back.display();
        toMisc.display();
        toKeyBindings.display();
        
        currentGUI.display();
    }
    
    public void keyPressed() {
        currentGUI.keyPressed();
    }
    
    public void mousePressed() {
        back.mousePressed();
        toMisc.mousePressed();
        toKeyBindings.mousePressed();
        currentGUI.mousePressed();
    }
    
    public void mouseReleased() {
        back.mouseReleased();
        toMisc.mouseReleased();
        toKeyBindings.mouseReleased();
        currentGUI.mouseReleased();
    }
    
    public String goTo() {
        if (back.hasBeenPressed())
            return "main";
        if (toMisc.hasBeenPressed())
            currentGUI = misc;
        if (toKeyBindings.hasBeenPressed())
            currentGUI = keyBindings;
        return "";
    }
}
