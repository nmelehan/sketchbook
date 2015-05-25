public class Artist {
  ArrayList<Stroke> history; // the "model"
  
  HCanvas hcanvas; // the "view"
  
  boolean liveUpdate = true;
  
  public Artist() {
    this.history = new ArrayList<Stroke>();
    
    hcanvas = new HCanvas();
    H.add(hcanvas);
  }
  
  public void clearCanvas() {
    // havent figured out how to clear the canvas
    for(HDrawable.HDrawableIterator it=hcanvas.iterator();it.hasNext();) {
      it.remove();
      it.next();
    }
  }
  
  public void addStroke(Stroke stroke) {
    history.add(stroke);
    if (liveUpdate) {
      drawStroke(stroke);
    }
  }
  
  private void drawStroke(Stroke stroke) {
    HDrawable mark = new HRect(stroke.penPressure*30)
      .rounding(10)
      .noStroke()
      .fill(#ECECEC)
      .anchorAt(H.CENTER)
      .loc(stroke.x, stroke.y)
    ;
    
    HTween tween = new HTween()
        .target(mark)
        .property(H.SIZE)
        .start(0)
        .end(stroke.penPressure*60)
        .ease(.5).spring(0);
  
    hcanvas.add(mark);
  }
  
  public void drawHistory() {
    for (int i = 0; i < history.size(); i++) {
      drawStroke(history.get(i)); 
    }
  }
}
