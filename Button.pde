public class Button{
    color textColor, buttonColor;
    int x, y, width, height;
    boolean hasBeenPressed;
    String text;

    public Button(String text_, color textColor_, int x_, int y_, int width_, int height_, color buttonColor_){
        text = text_;
        textColor = textColor_;
        buttonColor = buttonColor_;
        x = x_;
        y = y_;
        width = width_;
        height = height_;
    }

    public void display(){
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        fill(buttonColor);
        rect(x, y, width, height);

        fill(textColor);
        textAlign(CENTER);
        textSize(width / text.length());
        text(text, x, y);

        popMatrix();
        popStyle();
    }

    public void mousePressed(){
        pushStyle();
        pushMatrix();

        rectMode(CENTER);
        fill(0, 50);
        rect(x, y, width, height);

        popMatrix();
        popStyle();
    }

    public void mouseReleased() {
        hasBeenPressed = true;
    }
}