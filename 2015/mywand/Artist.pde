public class Artist {
  ArrayList<Stroke> history; // the "model"
  
  private PGraphics canvas; // the "view"
  
  HCanvas canvas;
  HRect brush;
  
  boolean liveUpdate = true;
  
  private int canvasWidth, canvasHeight;
  
  public Artist() {
    this.history = new ArrayList<Stroke>();
    this.canvasWidth = 100;
    this.canvasHeight = 100;
    
    resetCanvas();
    
    canvas = new HCanvas();
    H.add(canvas);
    
    
  }
  
  public void resetCanvas() {
    this.canvas = createGraphics(canvasWidth, canvasHeight);
    this.canvas.beginDraw();
    this.canvas.endDraw();
  }
  
  public void setCanvasSize(int canvasWidth, int canvasHeight) {
     this.canvasWidth = canvasWidth;
     this.canvasHeight = canvasHeight;
     resetCanvas();
  }
  
  public PGraphics getCanvas() {
    return this.canvas; 
  }
  
  public void addStroke(Stroke stroke) {
    history.add(stroke);
    if (liveUpdate) {
      drawStroke(stroke);
    }
  }
  
  private void drawStroke(Stroke stroke) {
    PGraphics context = this.canvas;
    
    context.beginDraw();
    context.noStroke();
    context.fill(stroke.penPressure*255, 0, 255);
    context.ellipse(stroke.x, stroke.y, stroke.penPressure*30, stroke.penPressure*30);
    context.endDraw();
  }
  
  public void drawHistory() {
    for (int i = 0; i < history.size(); i++) {
      drawStroke(history.get(i)); 
    }
  }
}
