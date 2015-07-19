public class PCHGraphicsDrawable extends HDrawable {

	// Properties

	private PGraphics _graphics;

	// Constructors

	public PCHGraphicsDrawable(PGraphics graphics) {
		_graphics = graphics;
		_width = graphics.width;
		_height = graphics.height;
	}

	// Synthesizers

	public PGraphics graphics() {
		return _graphics;
	}

	public PCHGraphicsDrawable graphics(PGraphics graphics) {
		_graphics = graphics;
		size(graphics.width, graphics.height);

		return this;
	}

	// Class methods

	// Subclass methods

	public PCHGraphicsDrawable createCopy() {
		// PGraphics graphicsCopy = createGraphics(_graphics.width, _graphics.height, _graphics.renderer);
		// graphicsCopy.loadPixels();
		// arrayCopy(_graphics.pixels, graphicsCopy.pixels);
		// graphicsCopy.updatePixels();

		PCHGraphicsDrawable copy = new PCHGraphicsDrawable(_graphics);
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		// image to g
		g.image(_graphics,0,0,_width,_height);
	}
}