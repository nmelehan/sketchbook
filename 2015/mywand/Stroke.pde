public class Stroke {
  PVector location;
  
  float penPressure;
  
  public Stroke() {
    this.location = new PVector(0, 0);
  } 
  
  public Stroke(float x, float y, float penPressure) {
    this.location = new PVector(x, y);
    this.penPressure = penPressure;
  } 
}
