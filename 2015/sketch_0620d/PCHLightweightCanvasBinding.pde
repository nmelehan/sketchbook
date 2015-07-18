public class PCHLightweightCanvasBinding {

	// Properties

	private HDrawable _drawable;
	private HBehavior _behavior;
	private int _cycle;
	private boolean _persistForever;

	// Constructors

	public PCHLightweightCanvasBinding(HDrawable drawable, HBehavior behavior, int numberOfCycles) {
		_drawable = drawable;
		_behavior = behavior;
		_cycle = numberOfCycles;

		_persistForever = false;
	}

	// Synthesizers

	public HDrawable drawable() {
		return _drawable;
	}

	public HBehavior behavior() {
		return _behavior;
	}

	public int cycle() {
		return _cycle;
	}

	public void cycle(int cycle) {
		_cycle = cycle;
	}

	public boolean persistForever() {
		return _persistForever;
	}

	public void persistForever(boolean persistForever) {
		_persistForever = persistForever;
	}

	// Class methods

	public int countDown() {
		if(!_persistForever) {
			_cycle--;
		}

		return _cycle;
	}
}