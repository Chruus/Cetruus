import java.awt.event.KeyEvent;

public class GUISettingsAudio extends GUI{
    
    int scale;
    color textColor, backgroundColor;
    Slider musicVolume, soundVolume;
    SaveFile file;
    
    public GUISettingsAudio(int scale_, color textColor, color backgroundColor) {
        super(scale_);
        this.scale = Cetruus.scale;
        this.textColor = textColor;
        this.backgroundColor = backgroundColor;
        
        this.file = Cetruus.file;
        
        musicVolume = new Slider(width / 2, scale * 7, width * 3 / 4, height / 20, 20, backgroundColor,(color)(brightness(backgroundColor) / 2));
        soundVolume = new Slider(width / 2, scale * 12, width * 3 / 4, height / 20, 20, backgroundColor,(color)(brightness(backgroundColor) / 2));
        
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
        textSize(20);
        text("Music Volume", width / 2, scale * 5.5);
        text("Sound Volume", width / 2, scale * 10.5);
        
        popStyle();
        popMatrix();
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