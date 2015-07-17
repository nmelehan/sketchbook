public class PCHLightweightCanvas extends HCanvas {

	// Properties

	private ArrayList<HCallback> _canvasAdditions;
	private ArrayList<HCallback> _canvasSubtractions;

	int _canvasAdditionRateLimit;

	// Constructors

	public void init() {
		_canvasAdditions = new ArrayList<HCallback>();
		_canvasSubtractions = new ArrayList<HCallback>();

		_canvasAdditionRateLimit = 0;

		super.autoClear(false);
	}

	public PCHLightweightCanvas() {
		super();

		init();
	}
	public PCHLightweightCanvas(String bufferRenderer) {
		super(bufferRenderer);

		init();
	}
	public PCHLightweightCanvas(float w, float h) {
		super(w, h);

		init();
	}
	public PCHLightweightCanvas(float w, float h, String bufferRenderer) {
		super(w, h, bufferRenderer);

		init();
	}

	// Synthesizers

	int canvasAdditionRateLimit() {
		return _canvasAdditionRateLimit;
	}

	PCHLightweightCanvas canvasAdditionRateLimit(int canvasAdditionRateLimit) {
		_canvasAdditionRateLimit = canvasAdditionRateLimit;

		return this;
	}

	// Class methods

	public PCHLightweightCanvas lightweightAdd(final HDrawable d) {
		HCallback canvasAddition = new HCallback() {
				public void run(Object obj) {
					PCHLightweightCanvas lwc = (PCHLightweightCanvas)obj;
					add(d);
					lwc.lightweightRemove(d);
				}
			};

		_canvasAdditions.add(canvasAddition);

		return this;
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration) {
		HCallback canvasAddition = new HCallback() {
				public void run(Object obj) {
					add(d);

					// Meaning: passing a duration of zero
					// will persist the drawable on the canvas
					if (duration == 0) {
						return;
					}

					final PCHLightweightCanvas lwc = (PCHLightweightCanvas)obj;
					new HTimer(duration, 2).callback(
							new HCallback() {
									public void run(Object obj) {
										int cycleCount = (Integer)obj;
										if (cycleCount >= 1) {
											lwc.lightweightRemove(d);
										}
									}
								}
						);
				}
			};

		_canvasAdditions.add(canvasAddition);

		return this;
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration, final HBehavior b) {
		HCallback canvasAddition = new HCallback() {
				public void run(Object obj) {
					add(d);
					b.register();

					// Meaning: passing a duration of zero
					// will persist the drawable on the canvas
					if (duration == 0) {
						return;
					}

					final PCHLightweightCanvas lwc = (PCHLightweightCanvas)obj;
					new HTimer(duration, 2).callback(
							new HCallback() {
									public void run(Object obj) {
										int cycleCount = (Integer)obj;
										if (cycleCount >= 1) {
											lwc.lightweightRemove(d, b);
										}
									}
								}
						);
				}
			};

		_canvasAdditions.add(canvasAddition);

		return this;
	}

	public PCHLightweightCanvas lightweightRemove(final HDrawable d) {
		HCallback canvasSubtraction = new HCallback() {
				public void run(Object obj) {
					remove(d);
				}
			};

		_canvasSubtractions.add(canvasSubtraction);

		return this;
	}

	public PCHLightweightCanvas lightweightRemove(final HDrawable d, final HBehavior b) {
		HCallback canvasSubtraction = new HCallback() {
				public void run(Object obj) {
					b.unregister();
					remove(d);
				}
			};

		_canvasSubtractions.add(canvasSubtraction);

		return this;
	}

	// Subclass methods

	public PCHLightweightCanvas createCopy() {
		PCHLightweightCanvas copy = new PCHLightweightCanvas(_width, _height, renderer());
		copy._canvasAdditionRateLimit = _canvasAdditionRateLimit;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	void depleteCanvasSubtractions() {
		HCallback c = _canvasSubtractions.remove(0);
		c.run(this);

		if (_canvasSubtractions.size() > 0) {
			depleteCanvasSubtractions();
		}
	}

	public void paintAll(PGraphics g, boolean zFlag, float alphaPc) {
		// add drawables
		int numberOfAdditions = _canvasAdditionRateLimit == 0
			? _canvasAdditions.size()
			: min(_canvasAdditions.size(), _canvasAdditionRateLimit);

		for (int i = 0; i < numberOfAdditions; i++) {
			HCallback c = _canvasAdditions.remove(0);
			c.run(this);
		}

		super.paintAll(g, zFlag, alphaPc);

		// remove drawables
		println(_canvasSubtractions.size());
		// while (_canvasSubtractions.size() > 0) {
		// 	HCallback c = _canvasSubtractions.remove(0);
		// 	c.run(this);
		// }
		if (_canvasSubtractions.size() > 0) {
			depleteCanvasSubtractions();
		}
	}
}