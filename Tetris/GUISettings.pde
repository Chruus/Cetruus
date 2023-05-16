public class GUISettings extends GUI{
    GUI keyBindings, misc, video, currentGUI;
    Button toKeyBindings, toMisc, toVideo, back;
    
    public GUISettings(int scale_, color textColor, color backgroundColor, KeyBindings keyBinds) {
        super(scale_);
        
        keyBindings = new GUISettingsKeyBindings(scale_, textColor, backgroundColor, keyBinds);
        misc = new GUISettingsMisc(scale_ ,textColor, backgroundColor, keyBinds);
        currentGUI = misc;
        
        back = new Button("Back", textColor,(int)(1.5 * scale), 1 * scale, 3 * scale, 2 * scale, backgroundColor);
        toVideo = new Button("Video", textColor,(int)(4.5 * scale), 1 * scale, 3 * scale, 2 * scale, backgroundColor);
        toMisc = new Button("Misc", textColor,(int)(7.5 * scale), 1 * scale, 3 * scale, 2 * scale, backgroundColor);
        toKeyBindings = new Button("Key Binds", textColor,(int)(11.5 * scale), 1 * scale, 5 * scale, 2 * scale, backgroundColor);
    }
    
    public void display() {
        back.display();
        toVideo.display();
        toMisc.display();
        toKeyBindings.display();
        
        currentGUI.display();
    }
    
    public void mousePressed() {
        back.mousePressed();
        toVideo.mousePressed();
        toMisc.mousePressed();
        toKeyBindings.mousePressed();
        currentGUI.mousePressed();
    }
    
    public void mouseReleased() {
        back.mouseReleased();
        toVideo.mouseReleased();
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