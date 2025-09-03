public class GUISettings extends GUI{
    GUI keyBindings, DAS, audio, currentGUI;
    Button toKeyBindings, toDAS, toAudio, back;
    
    public GUISettings(color textColor, color backgroundColor) {    
        
        DAS = new GUISettingsDAS(textColor, backgroundColor);
        currentGUI = DAS;
        
        keyBindings = new GUISettingsKeyBindings(textColor, backgroundColor);
        audio = new GUISettingsAudio(textColor, backgroundColor);
        
        int backX = width / 2 - (int)(5.5 * Cetruus.scale);
        int toDasX = width / 2 - (int)(2 * Cetruus.scale);
        int toKeyBindingsX = width / 2 + (int)(1.5 * Cetruus.scale);
        int toAudioX = width / 2 + (int)(4 * Cetruus.scale);
        int Y = height / 2 - (int)(8.5 * Cetruus.scale);
        int backWidth = (int)(2.5 * Cetruus.scale);
        int restWidth = (int)(3 * Cetruus.scale);
        int height = (int)(1.5 * Cetruus.scale);
        back = new Button("Back", textColor, backX, Y, backWidth, height, backgroundColor);
        toDAS = new Button("DAS", textColor, toDasX, Y, restWidth, height, backgroundColor);
        toKeyBindings = new Button("Keyboard", textColor, toKeyBindingsX, Y, restWidth, height, backgroundColor);
        toAudio = new Button("Audio", textColor, toAudioX, Y, restWidth, height, backgroundColor);
    }
    
    public void display() {
        back.display();
        toDAS.display();
        toKeyBindings.display();
        toAudio.display();
        
        currentGUI.display();
    }
    
    public void windowResized() {
        int backX = width / 2 - (int)(5.5 * Cetruus.scale);
        int toDasX = width / 2 - (int)(2 * Cetruus.scale);
        int toKeyBindingsX = width / 2 + (int)(1.5 * Cetruus.scale);
        int toAudioX = width / 2 + (int)(5 * Cetruus.scale);
        int Y = height / 2 - (int)(8.5 * Cetruus.scale);
        int backWidth = (int)(2.5 * Cetruus.scale);
        int restWidth = (int)(3 * Cetruus.scale);
        int height = (int)(1.5 * Cetruus.scale);
        
        back.resize(backX, Y, backWidth, height);
        toDAS.resize(toDasX, Y, restWidth, height);
        toKeyBindings.resize(toKeyBindingsX, Y, restWidth, height);
        toAudio.resize(toAudioX, Y, restWidth, height);
        
        keyBindings.windowResized();
        DAS.windowResized();
        audio.windowResized();
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
