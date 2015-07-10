public class PCHLinearGradient extends HDrawable {

	// Properties
	//
	//

	public static final int XAXIS = 1, YAXIS = 2;
	color _startColor, _endColor;
	int _axis;

	// Constructors
	//
	//

	public PCHLinearGradient() {
		_axis = XAXIS;
	}

	public PCHLinearGradient(color startColor, color endColor) {
		_startColor = startColor;
		_endColor = endColor;
		_axis = XAXIS;
	}

	// Synthesizers
	//
	//

	public int axis() {
		return _axis;
	}

	public PCHLinearGradient axis(int axis) {
		_axis = axis;

		return this;
	}

	public color startColor() {
		return _startColor;
	}

	public PCHLinearGradient startColor(color startColor) {
		_startColor = startColor;

		return this;
	}

	public color endColor() {
		return _startColor;
	}

	public PCHLinearGradient endColor(color endColor) {
		_endColor = endColor;

		return this;
	}

	// Subclass methods
	//
	//

	public PCHLinearGradient createCopy() {
		PCHLinearGradient copy = new PCHLinearGradient();
		copy._startColor = _startColor;
		copy._endColor = _endColor;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	private color colorWithAlpha(color aColor, float alphaPc) {
		int r = (aColor >> 16) & 0xFF;  	// Faster way of getting red(aColor)
		int g = (aColor >> 8) & 0xFF;   	// Faster way of getting green(aColor)
		int b = aColor & 0xFF; 			// Faster way of getting blue(aColor)
		int a = (aColor >> 24) & 0xFF;
		return color(r, g, b, a*alphaPc);
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		// applyStyle(g, currAlphaPc);
		if (_axis == XAXIS) {
			for (int i = 0; i <= _width; i++) {
				HPath line = new HPath();

				float inter = H.app().map(i, 0, _width, 0, 1);
				color c = colorWithAlpha(H.app().lerpColor(_startColor, _endColor, inter), currAlphaPc);
				// mix c and currAlphaPc

				g.stroke(c);
				g.strokeCap(SQUARE);
				g.strokeWeight(3);
				g.line(drawX+i, drawY, drawX+i, drawY+_height);
		    }
		}
		else if (_axis == YAXIS) {
			for (int i = 0; i <= _height; i++) {
				HPath line = new HPath();

				float inter = H.app().map(i, 0, _height, 0, 1);
				color c = colorWithAlpha(H.app().lerpColor(_startColor, _endColor, inter), currAlphaPc);

				g.stroke(c);
				g.strokeCap(SQUARE);
				g.strokeWeight(3);
				g.line(drawX, drawY+i, drawX+_width, drawY+i);
		    }
		}
	}
}