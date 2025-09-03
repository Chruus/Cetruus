import java.awt.event.KeyEvent;

public class GUISettingsAudio extends GUI{
    
    color textColor, backgroundColor;
    Slider musicVolume, soundVolume;
    SaveFile file;
    
    public GUISettingsAudio(color textColor, color backgroundColor) {
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        this.file = Cetruus.file;
        
        int x = width / 2;
        int musicY = height / 2 - Cetruus.scale * 3;
        int soundY = height / 2 + Cetruus.scale * 2;
        int w = width * 3 / 4;
        int h = height / 20;
        
        musicVolume = new Slider(x, musicY, w, h, 20, backgroundColor,(color)(brightness(backgroundColor) / 2));
        soundVolume = new Slider(x, soundY, w, h, 20, backgroundColor,(color)(brightness(backgroundColor) / 2));
        
        Cetruus.musicAmp = file.loadMusicVolume() / 100.0;
        Cetruus.soundAmp = file.loadSoundVolume() / 100.0;
        
        musicVolume.setSliderPos((int)(Cetruus.musicAmp * 100 / 5));
        soundVolume.setSliderPos((int)(Cetruus.soundAmp * 100 / 5));
    }
    
    public void display() {
        pushMatrix();
        pushStyle();
        
        musicVolume.display();
        soundVolume.display();
        
        fill(255);
        textAlign(CENTER);
        textSize(Cetruus.scale * 2 / 3);
        text("Music Volume", width / 2, height / 2 - Cetruus.scale * 4.5);
        text("Sound Volume", width / 2, height / 2 + Cetruus.scale * 0.5);
        
        popStyle();
        popMatrix();
    }
    
    public void windowResized() {
        int x = width / 2;
        int musicY = height / 2 - Cetruus.scale * 3;
        int soundY = height / 2 + Cetruus.scale * 2;
        int w = (int)(10.5 * Cetruus.scale);
        int h = Cetruus.scale;
        
        musicVolume.resize(x, musicY, w, h);
        soundVolume.resize(x, soundY, w, h);
    }
    
    public void keyPressed() {
        
    }
    
    public void mousePressed() {
        musicVolume.mousePressed();
        soundVolume.mousePressed();
    }
    
    public void mouseReleased() {
        musicVolume.mouseReleased();
        soundVolume.mouseReleased();
        
        if (musicVolume.hasBeenPressed() || soundVolume.hasBeenPressed()) {
            Cetruus.musicAmp = musicVolume.sliderPos() * 5.0 / 100.0;
            Cetruus.soundAmp = soundVolume.sliderPos() * 5.0 / 100.0;
            file.saveVolume(Cetruus.musicAmp, Cetruus.soundAmp);
        }
    }
    
    public String goTo() {
        return "";
    }
}