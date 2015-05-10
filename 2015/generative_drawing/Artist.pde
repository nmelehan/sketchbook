public class Artist {
  ArrayList<Stroke> history;
  
  public Artist() {
    this.history = new ArrayList<Stroke>();
  }
  
  public void addStroke(Stroke stroke) {
    history.add(stroke);
  }
  
  public void drawStroke(Stroke stroke, PGraphics context) {
    context.beginDraw();
    context.noStroke();
    context.fill(stroke.penPressure*255, 0, 255);
    context.ellipse(stroke.x, stroke.y, stroke.penPressure*30, stroke.penPressure*30);
    context.endDraw();
  }
}
