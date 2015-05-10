public class Artist {
  ArrayList<Stroke> history;
  
  public Artist() {
    this.history = new ArrayList<Stroke>();
  }
  
  public void addStroke(Stroke stroke) {
    history.add(stroke);
  }
  
  public void drawStroke(Stroke stroke) {
    noStroke();
    fill(25);
    ellipse(stroke.x, stroke.y, stroke.penPressure*30, stroke.penPressure*30);
  }
}
