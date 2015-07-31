public class Artist {
  ArrayList<StrokeSegment> history; // the "model"
  
  HCanvas hcanvas; // the "view"
  HRect mark;

  HPath strokeSegmentFragmentMark;
  
  boolean liveUpdate = true;
  
  public Artist() {
    this.history = new ArrayList<StrokeSegment>();
    
    hcanvas = new HCanvas().autoClear(false);
    mark = new HRect();
    mark.visibility(false);
    H.add(hcanvas);
    hcanvas.add(mark);

    strokeSegmentFragmentMark = new HPath();
    strokeSegmentFragmentMark.stroke(255);
    //strokeSegmentFragmentMark.visibility(false);
    hcanvas.add(strokeSegmentFragmentMark);
  }
  
  public void clearCanvas() {
    // havent figured out how to clear the canvas
    for(HDrawable.HDrawableIterator it=hcanvas.iterator();it.hasNext();) {
      it.remove();
      it.next();
    }
  }
  
  public void addStroke(Stroke stroke) {
    addStroke(stroke, false);
  }
  
  public void addStroke(Stroke stroke, boolean newSegment) {
    StrokeSegment currentSegment;
    if (newSegment) {
      currentSegment = new StrokeSegment();
      history.add(currentSegment);
    }
    else {
      currentSegment = history.get(history.size()-1);
    }

    currentSegment.add(stroke);
    
    if (!newSegment && liveUpdate) {
      drawSegmentFragment(
        currentSegment.strokes.get(currentSegment.strokes.size()-2), 
        currentSegment.strokes.get(currentSegment.strokes.size()-1));
    }
  }

  private void drawPoint(Stroke stroke) {
    mark
      .rounding(10)
      .visibility(true)
      .size(stroke.penPressure*30)
      .noStroke()
      .fill(#ECECEC)
      .anchorAt(H.CENTER)
      .loc(stroke.location)
    ;
    
    // HTween tween = new HTween()
    //     .target(mark)
    //     .property(H.SIZE)
    //     .start(0)
    //     .end(stroke.penPressure*60)
    //     .ease(.5).spring(0);
  }
  
  private void drawSegmentFragment(Stroke stroke1, Stroke stroke2) {
    // clear vertices from strokeSegmentFragmentMark

    strokeSegmentFragmentMark.clear();

    strokeSegmentFragmentMark
      .vertex(stroke1.location.x, stroke1.location.y)
      .vertex(stroke2.location.x, stroke2.location.y)
      ;
  }
  
  public void drawHistory() {
    for (int i = 0; i < history.size(); i++) {
      StrokeSegment segment = history.get(i);
      if (segment.strokes.size() > 1) {
        for (int j = 1; j < segment.strokes.size(); j++) {
          drawSegmentFragment(segment.strokes.get(i-1), segment.strokes.get(i)); 
        }     
      } // end if()
      else {
        // drawPoint()
      } // end else
    } // end for()
  } // end drawHistory()
}
