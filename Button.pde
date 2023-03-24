public class Button{
    color textColor, buttonColor;
    int x, y, width, height;
    boolean hasBeenPressed;
    String text;

    public Button(text_, textColor_, x_, y_, width_, height_, buttonColor_){
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

    public void void mouseReleased() {
        hasBeenPressed = true;
    }
}