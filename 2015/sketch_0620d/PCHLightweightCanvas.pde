public class PCHLightweightCanvas extends HCanvas {

	// Properties

	private ArrayList<PCHLightweightCanvasBinding> _lightweightChildrenAdditionQueue;
	private ArrayList<PCHLightweightCanvasBinding> _lightweightChildrenSubtractionQueue;
	private ArrayList<PCHLightweightCanvasBinding> _lightweightChildren;

	int _canvasAdditionRateLimit;

	// Constructors

	public void init() {
		_lightweightChildrenAdditionQueue = new ArrayList<PCHLightweightCanvasBinding>();
		_lightweightChildrenSubtractionQueue = new ArrayList<PCHLightweightCanvasBinding>();
		_lightweightChildren = new ArrayList<PCHLightweightCanvasBinding>();

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
		return lightweightAdd(d, 1, null);
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration) {
		return lightweightAdd(d, duration, null);
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final int duration, final HBehavior b) {
		PCHLightweightCanvasBinding lightweightChild = new PCHLightweightCanvasBinding(d, b, duration);
		_lightweightChildrenAdditionQueue.add(lightweightChild);

		return this;
	}

	private void popOffLightweightChildrenAdditionQueue() {
		PCHLightweightCanvasBinding lightweightChild = _lightweightChildrenAdditionQueue.remove(0);

		_lightweightChildren.add(lightweightChild);
		add(lightweightChild.drawable());
		HBehavior b = lightweightChild.behavior();
		if (b != null) b.register();
	}

	private void popOffLightweightChildrenSubtractionQueue() {
		PCHLightweightCanvasBinding lightweightChild = _lightweightChildrenSubtractionQueue.remove(0);

		_lightweightChildren.remove(lightweightChild);
		remove(lightweightChild.drawable());
		HBehavior b = lightweightChild.behavior();
		if (b != null) b.unregister();
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
		for (PCHLightweightCanvasBinding lightweightChild : _lightweightChildren) {
			int cycle = lightweightChild.cycle();
			lightweightChild.cycle(--cycle);
			if (cycle < 1) {
				_lightweightChildrenSubtractionQueue.add(lightweightChild);
			}
		}

		while (_lightweightChildrenSubtractionQueue.size() > 0) {
			popOffLightweightChildrenSubtractionQueue();
		}
	}
}