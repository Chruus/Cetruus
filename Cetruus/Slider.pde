public class Slider{
    int x, y, w, h, sliderPos, xSlider, numPositions;
    color backgroundColor, sliderColor;
    boolean isPressed, hasBeenPressed;
    
    public Slider(int x, int y, int w, int h, int numPositions, color backgroundColor, color sliderColor) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.numPositions = numPositions;
        this.backgroundColor = backgroundColor;
        this.sliderColor = sliderColor;
        sliderPos = numPositions / 2;
    }
    
    public void display() {
        pushMatrix();
        pushStyle();
        
        rectMode(CENTER);
        fill(backgroundColor);
        rect(x, y, w, h);
        strokeWeight(1 + (int)(w * numPositions / 3000));
        
        for (int i = 0; i < numPositions; i++) {
            line((i * w / numPositions) + x - w / 2, y - h / 2,(i * w / numPositions) + x - w / 2, y + h / 2);
        }
        
        fill(sliderColor);
        
        if (isPressed) {
            if (mouseX > x + w / 2)
                sliderPos = numPositions;
            else if (mouseX < x - w / 2)
                sliderPos = 0;
            else
                sliderPos = Math.round((float)(mouseX - x + w / 2) / w * numPositions);
            
            fill(sliderColor / 2);
        }
        
        if (isPressed && mouseX <= x + w / 2 && mouseX >= x - w / 2)
            xSlider = mouseX;
        else
            xSlider = Math.round(x + (float)(sliderPos - numPositions / 2) * w / numPositions);
        
        rect(xSlider, y, w / 12, h * 2);
        
        popStyle();
        popMatrix();
    }
    
    public void mousePressed() {
        boolean mouseWithinSlider = mouseX < xSlider + w / 24 && mouseX > xSlider - w / 24 && mouseY < y + h && mouseY > y - h;
        boolean mouseWithinBar = mouseX < x + w / 2 + w / 24 & mouseX > x - w / 2 - w / 24 && mouseY < y + h / 2 && mouseY > y - h / 2;
        if (mouseWithinSlider || mouseWithinBar)
            isPressed = true;
    }
    
    public void mouseReleased() {
        isPressed = false;
        hasBeenPressed = true;
    }
    
    public boolean hasBeenPressed() {
        if (hasBeenPressed) {
            hasBeenPressed = false;
            return true;
        }
        return false;
    }
    
    public int sliderPos() {
        return sliderPos;
    }
    
    public void setSliderPos(int newPos) {
        if (newPos < 0 || newPos > numPositions)
            return;
        sliderPos = newPos;
    }
}