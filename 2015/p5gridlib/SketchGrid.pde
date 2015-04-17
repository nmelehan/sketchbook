import java.lang.reflect.*;

public class SketchGrid {
  int numRows;
  int numCols;
  
  float sketchWidth;
  float sketchHeight;
  
  Griddable[][] sketches;
  PGraphics[][] canvases;
  
  public SketchGrid(Object parentSketch, Griddable sketch) {
    numRows = 2;
    numCols = 2;
    
    sketchWidth = 100;
    sketchHeight = 100;
    
    Class sketchClass = sketch.getClass();
    println(sketchClass);
    sketches = new Griddable[numRows][numCols];
    canvases = new PGraphics[numRows][numCols];
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        try {
          Constructor<?> ctor = sketchClass.getDeclaredConstructor(parentSketch.getClass());
          sketches[i][j] = (Griddable)ctor.newInstance(parentSketch);
        } catch (Exception e) { 
          println(e);  
        }
        canvases[i][j] = createGraphics(100, 100);
      }
    }
  }
  
  public void draw() {
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        sketches[i][j].draw(canvases[i][j]);
        image(canvases[i][j], i*100, j*100);
      }
    }
  }
  
} // public class SketchGrid
