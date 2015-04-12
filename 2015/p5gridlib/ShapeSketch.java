import processing.core.*;

public class ShapeSketch implements Griddable {
  public PApplet parent;
  
  float frequency;
  
  public ShapeSketch() {
    frequency = (float)(Math.random()*6+.5);
  }
  
  public void setParent(PApplet parent) {
    this.parent = parent;
  }
  
  public void draw(PGraphics context) {
    context.beginDraw();
    context.background(255);
    context.ellipse(50+25*parent.cos(parent.radians(parent.frameCount*frequency)), 
      50+25*parent.sin(parent.radians(parent.frameCount*frequency)), 25, 25);
    context.endDraw();
  }
}
