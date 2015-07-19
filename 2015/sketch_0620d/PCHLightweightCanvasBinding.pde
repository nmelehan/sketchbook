public class PCHLightweightCanvasBinding {

	// Properties

	private HDrawable _drawable;
	private HBehavior _behavior;
	private int _cycle;
	private boolean _delayCycleCountDown;

	// Constructors

	public PCHLightweightCanvasBinding(HDrawable drawable) {
		this(drawable, null, 1);
	}

	public PCHLightweightCanvasBinding(HDrawable drawable, int numberOfCycles) {
		this(drawable, null, numberOfCycles);
	}

	public PCHLightweightCanvasBinding(HDrawable drawable, HBehavior behavior, int numberOfCycles) {
		_drawable = drawable;
		_behavior = behavior;
		_cycle = numberOfCycles;

		_delayCycleCountDown = false;
	}

	// Synthesizers

	public HDrawable drawable() {
		return _drawable;
	}

	public HBehavior behavior() {
		return _behavior;
	}

	public void behavior(HBehavior behavior) {
		_behavior = behavior;
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
}