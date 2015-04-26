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
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        try {
          Constructor<?> ctor = sketchClass.getDeclaredConstructor(parentSketch.getClass());
          sketches[i][j] = (Griddable)ctor.newInstance(parentSketch);
        } catch (Exception e) { 
          println(e);  
        }
        canvases[i][j] = createGraphics(sketchWidth, sketchHeight);
      }
    }
    
    distributeValuesForParameter(1, 6, "frequency");
  }
  
  private void distributeValuesForParameter(float minValue, float maxValue, String parameterName) {
    float numSketches = numRows*numCols;
    
    float value = minValue;
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        set(sketches[i][j], parameterName, value);
        value = lerp(minValue, maxValue, (i*numCols+j)/numSketches);
      }
    }
  }
  
  private boolean set(Object object, String fieldName, Object fieldValue) {
    Class<?> clazz = object.getClass();
    while (clazz != null) {
        try {
            Field field = clazz.getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(object, fieldValue);
            return true;
        } catch (NoSuchFieldException e) {
            clazz = clazz.getSuperclass();
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }
    return false;
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
