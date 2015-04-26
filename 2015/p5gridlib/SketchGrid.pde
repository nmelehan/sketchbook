import java.lang.reflect.*;

public class SketchGrid {
  int numRows;
  int numCols;
  
  int sketchWidth;
  int sketchHeight;
  
  Griddable[][] sketches;
  PGraphics[][] canvases;
  
  public SketchGrid(Object parentSketch, Griddable sketch) {
    this(parentSketch, sketch, 2, 2, 100, 100);
  }
  
  public SketchGrid(Object parentSketch, Griddable sketch, int numRows, int numCols, int sketchWidth, int sketchHeight) {
    this.numRows = numRows;
    this.numCols = numCols;
    
    this.sketchWidth = sketchWidth;
    this.sketchHeight = sketchHeight;
    
    Class sketchClass = sketch.getClass();
    println(sketchClass);
    sketches = new Griddable[numRows][numCols];
    canvases = new PGraphics[numRows][numCols];
    float frequency = 2;
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        try {
          Constructor<?> ctor = sketchClass.getDeclaredConstructor(parentSketch.getClass());
          sketches[i][j] = (Griddable)ctor.newInstance(parentSketch);
          ((ShapeSketch)sketches[i][j]).frequency = frequency;
          frequency += .05;
        } catch (Exception e) { 
          println(e);  
        }
        canvases[i][j] = createGraphics(sketchWidth, sketchHeight);
      }
    }
  }
  
  public void draw() {
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        sketches[i][j].draw(canvases[i][j]);
        image(canvases[i][j], j*sketchWidth, i*sketchHeight);
      }
    }
  }
  
} // public class SketchGrid
