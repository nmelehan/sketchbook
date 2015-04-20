public class ShapeSketch implements Griddable {
  float frequency;
  
  public ShapeSketch() {
    frequency = (float)(Math.random()*3+2);
  }
  
  public void draw(PGraphics context) {
    context.beginDraw();
    context.background(255);
    context.stroke(225);
    context.noFill();
    //context.rect(0, 0, context.width, context.height);
    context.stroke(25);
    float orbitRadius = context.width/4;
    float ellipseRadius = context.width/4;
    context.ellipse(context.width/2+orbitRadius*cos(radians(frameCount*frequency)), 
      context.height/2+orbitRadius*sin(radians(frameCount*frequency)), ellipseRadius, ellipseRadius);
    context.endDraw();
  }
}
