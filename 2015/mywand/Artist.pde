public class Artist {
  ArrayList<Stroke> history; // the "model"
  
  HCanvas hcanvas; // the "view"
  HRect mark;
  
  boolean liveUpdate = true;
  
  public Artist() {
    this.history = new ArrayList<Stroke>();
    
    hcanvas = new HCanvas().autoClear(false);
    mark = new HRect();
    mark.visibility(false);
    H.add(hcanvas);
    hcanvas.add(mark);
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
    mark
      .rounding(10)
      .visibility(true)
      .size(stroke.penPressure*30)
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
  }
  
  public void drawHistory() {
    for (int i = 0; i < history.size(); i++) {
      drawStroke(history.get(i)); 
    }
  }
}
