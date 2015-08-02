public class Brush {
	public CanvasDelegate _delegate;

	private ArrayList<StrokePathSegment> _pathSegmentQueue;
	private HDrawablePool _brushMarkPool;
	private HPath brushMark;

	public Brush() {
		this(null);
	}

	public Brush(CanvasDelegate delegate) {
		_pathSegmentQueue = new ArrayList<StrokePathSegment>();

		// brushMark = new HPath();
  //   	brushMark.stroke(255);
  //   	delegate.canvas().add(brushMark);

   //  	_brushMarkPool = new HDrawablePool(50)
   //  		.add(new HPath().stroke(255))
   //  		.autoParent(delegate.canvas())
   //  		.onRelease(
   //  			new HCallback() {
   //  				public void run(Object obj) {
   //  					HPath d = (HPath) obj;
   //  					d.clear();
   //  				}
   //  			})
   //  		.onCreate(
			// 	new HCallback() {
			// 		public void run(Object obj) {
			// 			final HPath d = (HPath) obj;

			// 			println("onCreate, queue size: " + _pathSegmentQueue.size());
			// 			StrokePathSegment segment = _pathSegmentQueue.remove(0);
			// 			println("onCreate, queue size: " + _pathSegmentQueue.size());
			// 			d
			// 				.vertex(0, 0)
			// 			    .vertex(segment._stroke2.location.x-segment._stroke1.location.x, segment._stroke2.location.y-segment._stroke1.location.y)
			// 			    .loc(segment._stroke1.location.x, segment._stroke1.location.y)
			// 			    .strokeWeight(segment._stroke1.penPressure*10)
			// 			    .anchorAt(H.TOP | H.LEFT)
			// 			    ;	

			// 			HTween fadeIn = new HTween()
			// 				.target(d)
			// 				.property(H.ALPHA)
			// 				.start(0)
			// 				.end(255)
			// 				.ease(.05)
			// 				;

			// 			HCallback c = new HCallback() {
			// 					public void run(Object obj) {
			// 						println("release");
			// 						// d.popOut();
			// 						_brushMarkPool.release(d);
			// 					}
			// 				};

			// 			fadeIn.callback(c).register();

			// 			// HRotate r = new HRotate();
			// 			// r.target(d).speed( random(-2,2) );


			// 		} // end -- run()
			// 	} // end -- new HCallback()
			// )
			// ;

		_delegate = delegate;
	}

	public void queuePathSegment(StrokePathSegment segment) {
		_pathSegmentQueue.add(segment);
	}

	// void drawSegment(StrokePathSegment segment) {
	// 	brushMark.clear();

	//     brushMark
	//       .vertex(segment._stroke1.location.x, segment._stroke1.location.y)
	//       .vertex(segment._stroke2.location.x, segment._stroke2.location.y)
	//       .strokeWeight(segment._stroke1.penPressure*10);
	//       ;
	// }

	public void generateBrushMarksForPathSegment(StrokePathSegment segment) {
		final HPath brushMark = new HPath();
		brushMark
			.vertex(0, 0)
		    .vertex(segment._stroke2.location.x-segment._stroke1.location.x, segment._stroke2.location.y-segment._stroke1.location.y)
		    .loc(segment._stroke1.location.x, segment._stroke1.location.y)
		    .strokeWeight(segment._stroke1.penPressure*10)
		    .stroke(255)
		    .anchorAt(H.TOP | H.LEFT)
		    ;	
		_delegate.canvas().add(brushMark);

		HTween fadeIn = new HTween()
			.target(brushMark)
			.property(H.ALPHA)
			.start(0)
			.end(255)
			.ease(.01)
			;

		HCallback c = new HCallback() {
				public void run(Object obj) {
					brushMark.popOut();
				}
			};

		fadeIn.callback(c).register();
	}

	public void draw() {
		// println("draw, number available: " + (_brushMarkPool.max() - _brushMarkPool.numActive()));
		// println("draw, queue size: " + _pathSegmentQueue.size());
		// int numberOfRequests = min(_brushMarkPool.max() - _brushMarkPool.numActive(), _pathSegmentQueue.size());
		// for (int i = 0; i < numberOfRequests; i++) {
		// 	_brushMarkPool.request();
		// }
		while(_pathSegmentQueue.size() > 0) {
			StrokePathSegment segment = _pathSegmentQueue.remove(0);
			generateBrushMarksForPathSegment(segment);
		}
	}
}