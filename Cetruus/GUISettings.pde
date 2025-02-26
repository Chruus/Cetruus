public class GUISettings extends GUI{
    GUI keyBindings, DAS, audio, currentGUI;
    Button toKeyBindings, toDAS, toAudio, back;
    
    public GUISettings(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        
        DAS = new GUISettingsDAS(scale_ ,textColor, backgroundColor);
        currentGUI = DAS;
        
        keyBindings = new GUISettingsKeyBindings(scale_, textColor, backgroundColor);
        audio = new GUISettingsAudio(scale_, textColor, backgroundColor);
        
        back = new Button("Back", textColor,(int)(1.5 * scale),(int)(1.5 * scale),(int)(2.5 * scale),(int)(1.5 * scale), backgroundColor);
        toDAS = new Button("DAS", textColor,(int)(5 * scale),(int)(1.5 * scale),(int)(3 * scale),(int)(1.5 * scale), backgroundColor);
        toKeyBindings = new Button("Keyboard", textColor,(int)(8.5 * scale),(int)(1.5 * scale),(int)(3 * scale),(int)(1.5 * scale), backgroundColor);
        toAudio = new Button("Audio", textColor,(int)(12 * scale),(int)(1.5 * scale),(int)(3 * scale),(int)(1.5 * scale), backgroundColor);
    }
    
    public void display() {
        back.display();
        toDAS.display();
        toKeyBindings.display();
        toAudio.display();
        
        currentGUI.display();
    }
    
    public void keyPressed() {
        currentGUI.keyPressed();
    }
    
    public void mousePressed() {
        back.mousePressed();
        toDAS.mousePressed();
        toKeyBindings.mousePressed();
        toAudio.mousePressed();
        currentGUI.mousePressed();
    }
    
    public void mouseReleased() {
        back.mouseReleased();
        toDAS.mouseReleased();
        toKeyBindings.mouseReleased();
        toAudio.mouseReleased();
        currentGUI.mouseReleased();
    }
    
    public String goTo() {
        if (back.hasBeenPressed())
            return "main";
        if (toDAS.hasBeenPressed())
            currentGUI = DAS;
        if (toKeyBindings.hasBeenPressed())
            currentGUI = keyBindings;
        if (toAudio.hasBeenPressed())
            currentGUI = audio;
        return "";
    }
}
