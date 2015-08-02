public class Stroke {
  PVector location;
  
  float penPressure;
  
  public Stroke() {
    this(0, 0, 1);
  } 
  
  public Stroke(float x, float y, float penPressure) {
    this(new PVector(x, y), penPressure);
  } 
  
  public Stroke(PVector location, float penPressure) {
    this.location = location;
    this.penPressure = penPressure;
  } 

  public Stroke createCopy() {
  	return new Stroke(this.location.x, this.location.y, this.penPressure);
  }
}
