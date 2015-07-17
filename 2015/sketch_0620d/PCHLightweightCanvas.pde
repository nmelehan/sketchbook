public class PCHLightweightCanvas extends HCanvas {

	// Properties

	private ArrayList<HCallback> _canvasAdditions;
	private ArrayList<HDrawable> _canvasSubtractions;

	int _canvasAdditionRateLimit;

	// Constructors

	public void init() {
		_canvasAdditions = new ArrayList<HCallback>();
		_canvasSubtractions = new ArrayList<HDrawable>();

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

	// Class methods

	public PCHLightweightCanvas lightweightAdd(final HDrawable d) {
		HCallback canvasAddition = new HCallback() {
				public void run(Object obj) {
					PCHLightweightCanvas pc = (PCHLightweightCanvas)obj;
					add(d);
					pc.lightweightRemove(d);
				}
			};

		_canvasAdditions.add(canvasAddition);

		return this;
	}

	public PCHLightweightCanvas lightweightRemove(HDrawable d) {
		_canvasSubtractions.add(d);

		return this;
	}

	public PCHLightweightCanvas lightweightAdd(final HDrawable d, final HBehavior b) {
		return this;
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
			? _canvasAdditions.size()
			: min(_canvasAdditions.size(), _canvasAdditionRateLimit);

		for (int i = 0; i < numberOfAdditions; i++) {
			HCallback c = _canvasAdditions.remove(0);
			c.run(this);
		}

		super.paintAll(g, zFlag, alphaPc);

		// remove drawables
		while (_canvasSubtractions.size() > 0) {
			HDrawable d = _canvasSubtractions.remove(0);
			remove(d);
		}
	}
}