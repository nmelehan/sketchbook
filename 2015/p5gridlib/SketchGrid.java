import processing.core.*;

public class SketchGrid {
  PApplet parent;
  
  int numRows;
  int numCols;
  
  float sketchWidth;
  float sketchHeight;
  
  Griddable[][] sketches;
  PGraphics[][] canvases;
  
  public SketchGrid(PApplet parent, Griddable sketch) {
    this.parent = parent;
    
    numRows = 2;
    numCols = 2;
    
    sketchWidth = 100;
    sketchHeight = 100;
    
    Class sketchClass = sketch.getClass();
    sketches = new Griddable[numRows][numCols];
    canvases = new PGraphics[numRows][numCols];
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        try {
          sketches[i][j] = (Griddable)sketchClass.newInstance();
          sketches[i][j].setParent(parent);
        } catch (Exception e) { }
        canvases[i][j] = parent.createGraphics(100, 100);
      }
    }
  }
  
  public void draw() {
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        sketches[i][j].draw(canvases[i][j]);
        parent.image(canvases[i][j], i*100, j*100);
      }
    }
  }
  
} // public class SketchGrid
