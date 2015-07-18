public class PCHLightweightCanvasBinding {
	private HDrawable _drawable;
	private HBehavior _behavior;
	private int _cycle;

	public PCHLightweightCanvasBinding(HDrawable drawable, HBehavior behavior, int numberOfCycles) {
		_drawable = drawable;
		_behavior = behavior;
		_cycle = numberOfCycles;
	}

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
}