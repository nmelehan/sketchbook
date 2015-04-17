public class ShapeSketch implements Griddable {
  float frequency;
  
  public ShapeSketch() {
    frequency = (float)(Math.random()*6+.5);
  }
  
  public void draw(PGraphics context) {
    context.beginDraw();
    context.background(255);
    context.ellipse(50+25*cos(radians(frameCount*frequency)), 
      50+25*sin(radians(frameCount*frequency)), 25, 25);
    context.endDraw();
  }
}
