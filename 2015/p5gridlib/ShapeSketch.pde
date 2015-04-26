public class ShapeSketch implements Griddable {
  public float frequency;
  public float ellipseRadius;
  public float orbitRadius;
  
  public ShapeSketch() {
    frequency = (float)(Math.random()*3+2);
    ellipseRadius = 10;
    orbitRadius = 10;
  }
  
  public void draw(PGraphics context) {
    context.beginDraw();
    context.stroke(225);
    context.fill(255, 75);
    context.rect(0, 0, context.width, context.height);
    context.stroke(25);
    context.fill(255, 255);
    context.ellipse(context.width/2+orbitRadius*cos(radians(frameCount*frequency)), 
      context.height/2+orbitRadius*sin(radians(frameCount*frequency)), ellipseRadius, ellipseRadius);
    context.endDraw();
  }
}
