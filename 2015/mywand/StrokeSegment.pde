public class StrokeSegment {
  ArrayList<Stroke> strokes;
  
  public StrokeSegment() {
    this.strokes = new ArrayList<Stroke>();
  } 

  public void add(Stroke stroke) {
  	strokes.add(stroke);
  }
}