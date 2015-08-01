public class Brush {
	public CanvasDelegate _delegate;

	private ArrayList<StrokePathSegment> _pathSegmentQueue;
	// private HDrawablePool brushMarkPool;
	private HPath brushMark;

	public Brush() {
		this(null);
	}

	public Brush(CanvasDelegate delegate) {
		_pathSegmentQueue = new ArrayList<StrokePathSegment>();

		brushMark = new HPath();
    	brushMark.stroke(255);
    	delegate.canvas().add(brushMark);

		_delegate = delegate;
	}

	void queuePathSegment(StrokePathSegment segment) {
		_pathSegmentQueue.add(segment);
	}

	void drawSegment(StrokePathSegment segment) {
		brushMark.clear();

	    brushMark
	      .vertex(segment._stroke1.location.x, segment._stroke1.location.y)
	      .vertex(segment._stroke2.location.x, segment._stroke2.location.y)
	      .strokeWeight(segment._stroke1.penPressure*10);
	      ;
	}

	void draw() {
		while(_pathSegmentQueue.size() > 0) {
			StrokePathSegment segment = _pathSegmentQueue.remove(0);
			drawSegment(segment);
		}
	}
}