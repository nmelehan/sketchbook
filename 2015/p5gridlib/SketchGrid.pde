public class SketchGrid {
  int numRows;
  int numCols;
  
  float sketchWidth;
  float sketchHeight;
  
  Griddable[][] sketches;
  
  public SketchGrid() {
    numRows = 2;
    numCols = 2;
    
    sketchWidth = 100;
    sketchHeight = 100;
    
    sketches = new Griddable[numRows][numCols];
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
      }
    }
  }
  
  public void draw() {
    
  }
}
