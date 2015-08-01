public interface CanvasDelegate {
  public HCanvas canvas();
}

public class Artist implements CanvasDelegate {
  ArrayList<StrokePath> history; // the "model"
  
  HCanvas hcanvas; // the "view"
  Brush _brush;
  HRect mark;

  HPath strokePathFragmentMark;
  
  boolean liveUpdate = true;
  
  public Artist() {
    this.history = new ArrayList<StrokePath>();
    
    hcanvas = new HCanvas().autoClear(false);
    // mark = new HRect();
    // mark.visibility(false);
    H.add(hcanvas);
    // hcanvas.add(mark);

    _brush = new Brush(this);

    // strokePathFragmentMark = new HPath();
    // strokePathFragmentMark.stroke(255);
    // //strokePathFragmentMark.visibility(false);
    // hcanvas.add(strokePathFragmentMark);
  }

  public HCanvas canvas() {
    return hcanvas;
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
    StrokePath currentPath;
    if (newSegment) {
      currentPath = new StrokePath();
      history.add(currentPath);
    }
    else {
      currentPath = history.get(history.size()-1);
    }

    currentPath.add(stroke);
    
    if (!newSegment && liveUpdate) {
      // drawSegmentFragment(
      //   currentPath.strokes.get(currentPath.strokes.size()-2), 
      //   currentPath.strokes.get(currentPath.strokes.size()-1));
      StrokePathSegment segment = new StrokePathSegment(
          currentPath.strokes.get(currentPath.strokes.size()-2),
          currentPath.strokes.get(currentPath.strokes.size()-1));
      _brush.queuePathSegment(segment);

      if (random(1) > .9) {
        PVector location = new PVector(stroke.location.x+stroke.penPressure*20, stroke.location.y+stroke.penPressure*20);
        Stroke newStroke = new Stroke(location.x, location.y, stroke.penPressure);
        segment = new StrokePathSegment(
          currentPath.strokes.get(currentPath.strokes.size()-1),
          newStroke);
        _brush.queuePathSegment(segment);
      }
    }
  }

  public void draw() {
    _brush.draw();
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
    // clear vertices from strokePathFragmentMark

    strokePathFragmentMark.clear();

    strokePathFragmentMark
      .vertex(stroke1.location.x, stroke1.location.y)
      .vertex(stroke2.location.x, stroke2.location.y)
      ;
  }
  
  public void drawHistory() {
    for (int i = 0; i < history.size(); i++) {
      StrokePath path = history.get(i);
      if (path.strokes.size() > 1) {
        for (int j = 1; j < path.strokes.size(); j++) {
          drawSegmentFragment(path.strokes.get(i-1), path.strokes.get(i)); 
        }     
      } // end if()
      else {
        // drawPoint()
      } // end else
    } // end for()
  } // end drawHistory()
}
