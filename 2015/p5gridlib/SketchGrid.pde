import java.lang.reflect.*;
import java.util.*;

private class WatchedParameter {
  String parameterName;
  float startValue;
  float endValue;
  
  public WatchedParameter(String parameterName, float startValue, float endValue) {
    this.parameterName = parameterName;
    this.startValue = startValue;
    this.endValue = endValue;
  }
}

public class SketchGrid {
  int numRows;
  int numCols;
  
  int sketchWidth;
  int sketchHeight;
  
  Griddable[][] sketches;
  PGraphics[][] canvases;
  HashMap<String, WatchedParameter> watchedParameters;
  
  public SketchGrid(Object parentSketch, Griddable sketch) {
    this(parentSketch, sketch, 2, 2, 100, 100);
  }
  
  public SketchGrid(Object parentSketch, Griddable sketch, int numRows, int numCols, int sketchWidth, int sketchHeight) {
    this.numRows = numRows;
    this.numCols = numCols;
    
    this.sketchWidth = sketchWidth;
    this.sketchHeight = sketchHeight;
   
    sketches = new Griddable[numRows][numCols];
    canvases = new PGraphics[numRows][numCols];
    watchedParameters = new HashMap<String, WatchedParameter>();
    
    Class sketchClass = sketch.getClass();
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
  }
  
  private void distributeValuesForParameter(float startValue, float endValue, String parameterName) {
    float numSketches = numRows*numCols;
    
    float value = startValue;
    for (int i = 0; i < numRows; i++) {
      for (int j = 0; j < numCols; j++) {
        set(sketches[i][j], parameterName, value);
        value = lerp(startValue, endValue, (i*numCols+j)/numSketches);
      }
    }
  }
  
  public void watchParameter(String parameterName, float startValue, float endValue) {
    watchedParameters.put(parameterName, new WatchedParameter(parameterName, startValue, endValue));
    
    distributeValuesForParameter(startValue, endValue, parameterName);
  }
  
  public void setRangeForWatchedParameter(String parameterName, float startValue, float endValue) {
    WatchedParameter wp = watchedParameters.get(parameterName);
    wp.startValue = startValue;
    wp.endValue = endValue;
    distributeValuesForParameter(startValue, endValue, parameterName);
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
