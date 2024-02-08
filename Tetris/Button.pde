public class Button{
    boolean clicked, released;
    color textColor, buttonColor;
    int x, y, w, h, textSize;
    String text;
    
    public Button(String text_, color textColor_, int x_, int y_, int w_, int h_, color buttonColor_) {
        text = text_;
        textColor = textColor_;
        buttonColor = buttonColor_;
        x = x_;
        y = y_;
        w = w_;
        h = h_;
        textSize = Math.min((int)(w / text.length()),(int)(h / 2.8));
    } 
    
    public Button(String text_, color textColor_, int x_, int y_, int w_, int h_, int textSize_, color buttonColor_) {
        text = text_;
        textColor = textColor_;
        buttonColor = buttonColor_;
        x = x_;
        y = y_;
        w = w_;
        h = h_;
        textSize = textSize_;
    }
    
    public void display() {
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        if (mouseIsOnButton())
            fill(color((int)(red(buttonColor) * 0.8),(int)(green(buttonColor) * 0.8),(int)(blue(buttonColor) * 0.8)));
        else
            fill(buttonColor);
        rect(x, y, w, h, 5, 5, 5, 5);
        
        fill(textColor);
        textAlign(CENTER);
        textSize(textSize);
        text(text, x, y + textSize / 1.5);
        
        popMatrix();
        popStyle();
    }
    
    public void setText(String text_) {
        text = text_;
    }
    
    private boolean mouseIsOnButton() {
        if (mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2)
            return true;
        return false;
    }
    
    public boolean hasBeenPressed() {
        if (released) {
            released = false;
            return true;
        }
        return false;
    }
    
    public void mousePressed() {
        if (!mouseIsOnButton())
            return;
        clicked = true;
        buttonColor = color((int)(red(buttonColor) * 0.5),(int)(green(buttonColor) * 0.5),(int)(blue(buttonColor) * 0.5));
    }
    
    public void mouseReleased() {
        if (clicked) {
            buttonColor = color((int)(red(buttonColor) * 2),(int)(green(buttonColor) * 2),(int)(blue(buttonColor) * 2));
            clicked = false;
            released = true;
        }
    }
}