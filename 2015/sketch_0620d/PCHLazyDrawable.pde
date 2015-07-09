public static class PCHLazyDrawable extends HDrawable {

	// Properties

	private PGraphics _graphics;
	private String _renderer;
	private HDrawable _drawable;
	private boolean _needsRender;

	// Constructors

	public PCHLazyDrawable(HDrawable drawable) {
		this(drawable, PConstants.JAVA2D);
	}

	public PCHLazyDrawable(HDrawable drawable, String bufferRenderer) {
		_needsRender = true;
		_renderer = bufferRenderer;
		_drawable = drawable;

		updateBounds();
	}

	// Synthesizers

	public PCHLazyDrawable renderer(String s) {
		_renderer = s;
		_needsRender = true;
		updateBuffer();

		return this;
	}

	public String renderer() {
		return _renderer;
	}

	public PGraphics graphics() {
		return _graphics;
	}

	public HDrawable drawable() {
		return _drawable;
	}

	public PCHLazyDrawable drawable(HDrawable drawable) {
		_drawable = drawable;
		_needsRender = true;
		updateBounds();

		return this;
	}

	public boolean needsRender() {
		return _needsRender;
	}

	public PCHLazyDrawable needsRender(boolean needsRender) {
		_needsRender = needsRender;
		if(_needsRender) {
			updateBounds();
		}

		return this;
	}

	// Class methods

	protected void updateBounds() {
		PVector loc = new PVector(), size = new PVector();
		_drawable.bounds(loc,size);

		_width = size.x;
		_height = size.y;

		this.loc(loc);

		updateBuffer();
	}

	protected void updateBuffer() {
		int w = Math.round(_width);
		int h = Math.round(_height);
		_graphics = H.app().createGraphics(w, h, _renderer);
		_graphics.loadPixels();
		_graphics.beginDraw();
		_graphics.background(H.CLEAR);
		_graphics.endDraw();
		_width = w;
		_height = h;
	}

	// Subclass methods

	public PCHLazyDrawable createCopy() {
		PCHLazyDrawable copy = new PCHLazyDrawable(_drawable,_renderer);
		copy._needsRender = _needsRender;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		if (needsRender()) {
			println("rendering");
			_graphics.beginDraw();
			_graphics.background(H.CLEAR);
			_drawable.draw(_graphics, usesZ, drawX, drawY, currAlphaPc);
			_graphics.endDraw();
		}

		// image to g
		g.image(_graphics,0,0);

		needsRender(false);
	}
}