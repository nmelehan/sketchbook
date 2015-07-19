public class PCHLightweightCanvas extends HCanvas {

	public class PCHLightweightCanvasChild {

		// Properties

		private HDrawable _drawable;
		private ArrayList<HBehavior> _behaviors;
		private int _cycle;
		private boolean _delayCycleCountDown;

		// Constructors

		public PCHLightweightCanvasChild(HDrawable drawable) {
			this(drawable, new ArrayList<HBehavior>(), 1);
		}

		public PCHLightweightCanvasChild(HDrawable drawable, int numberOfCycles) {
			this(drawable, new ArrayList<HBehavior>(), numberOfCycles);
		}

		public PCHLightweightCanvasChild(HDrawable drawable, ArrayList<HBehavior> behaviors, int numberOfCycles) {
			_drawable = drawable;
			_behaviors = behaviors;
			_cycle = numberOfCycles;

			_delayCycleCountDown = false;
		}

		// Synthesizers

		public HDrawable drawable() {
			return _drawable;
		}

		public ArrayList<HBehavior> behaviors() {
			return _behaviors;
		}

		public int cycle() {
			return _cycle;
		}

		public void cycle(int cycle) {
			_cycle = cycle;
		}

		public boolean delayCycleCountDown() {
			return _delayCycleCountDown;
		}

		public void delayCycleCountDown(boolean delayCycleCountDown) {
			_delayCycleCountDown = delayCycleCountDown;
		}

		// Class methods

		public int countDown() {
			if(!_delayCycleCountDown) {
				_cycle--;
			}

			return _cycle;
		}

		public void registerBehaviors() {
			for (HBehavior b : _behaviors) {
				b.register();
			}
		}

		public void unregisterBehaviors() {
			for (HBehavior b : _behaviors) {
				b.unregister();
			}
		}
	}

	// Properties

	private ArrayList<PCHLightweightCanvasChild> _lightweightChildrenAdditionQueue;
	private ArrayList<PCHLightweightCanvasChild> _lightweightChildrenSubtractionQueue;
	private ArrayList<PCHLightweightCanvasChild> _lightweightChildren;

	int _canvasAdditionRateLimit;

	// Constructors

	public void init() {
		_lightweightChildrenAdditionQueue = new ArrayList<PCHLightweightCanvasChild>();
		_lightweightChildrenSubtractionQueue = new ArrayList<PCHLightweightCanvasChild>();
		_lightweightChildren = new ArrayList<PCHLightweightCanvasChild>();

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

	// public PGraphics graphicsCopy() {
	// 	PGraphics graphicsCopy = createGraphics(_graphics.width, _graphics.height, _renderer);
	// 	graphicsCopy.loadPixels();
	// 	arrayCopy(_graphics.pixels, graphicsCopy.pixels);
	// 	graphicsCopy.updatePixels();

	// 	return graphicsCopy;
	// }

	int canvasAdditionRateLimit() {
		return _canvasAdditionRateLimit;
	}

	PCHLightweightCanvas canvasAdditionRateLimit(int canvasAdditionRateLimit) {
		_canvasAdditionRateLimit = canvasAdditionRateLimit;

		return this;
	}

	// Class methods

	public PCHLightweightCanvas lightweightAdd(final HDrawable d) {
		_lightweightChildrenAdditionQueue.add(new PCHLightweightCanvasChild(d));

		return this;
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration) {
		_lightweightChildrenAdditionQueue.add(new PCHLightweightCanvasChild(d, duration));

		return this;
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration, final ArrayList<HBehavior> b) {
		_lightweightChildrenAdditionQueue.add(new PCHLightweightCanvasChild(d, b, duration));

		return this;
	}

	private void popOffLightweightChildrenAdditionQueue() {
		PCHLightweightCanvasChild lightweightChild = _lightweightChildrenAdditionQueue.remove(0);

		_lightweightChildren.add(lightweightChild);
		add(lightweightChild.drawable());
		lightweightChild.registerBehaviors();
	}

	private void popOffLightweightChildrenSubtractionQueue() {
		PCHLightweightCanvasChild lightweightChild = _lightweightChildrenSubtractionQueue.remove(0);

		_lightweightChildren.remove(lightweightChild);
		remove(lightweightChild.drawable());
		lightweightChild.unregisterBehaviors();
	}

	public boolean hasLightweightChildren() {
		return (_lightweightChildren.size() > 0 || _lightweightChildrenAdditionQueue.size() > 0);
	}

	// Subclass methods

	public PCHLightweightCanvas createCopy() {
		PCHLightweightCanvas copy = new PCHLightweightCanvas(_width, _height, renderer());
		copy._canvasAdditionRateLimit = _canvasAdditionRateLimit;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void paintAll(PGraphics g, boolean zFlag, float alphaPc) {
		// add drawables
		int numberOfAdditions = _canvasAdditionRateLimit == 0
			? _lightweightChildrenAdditionQueue.size()
			: min(_lightweightChildrenAdditionQueue.size(), _canvasAdditionRateLimit);

		for (int i = 0; i < numberOfAdditions; i++) {
			popOffLightweightChildrenAdditionQueue();
		}

		super.paintAll(g, zFlag, alphaPc);

		// remove drawables
		for (PCHLightweightCanvasChild lightweightChild : _lightweightChildren) {
			int cycle = lightweightChild.countDown();
			if (cycle < 1) {
				_lightweightChildrenSubtractionQueue.add(lightweightChild);
			}
		}

		while (_lightweightChildrenSubtractionQueue.size() > 0) {
			popOffLightweightChildrenSubtractionQueue();
		}
	}
}