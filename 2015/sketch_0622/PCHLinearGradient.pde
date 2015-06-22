public static class PCHLinearGradient extends HDrawable {
	public static final int XAXIS = 1, YAXIS = 2;

	color _startColor, _endColor;
	int _axis;

	public PCHLinearGradient createCopy() {
		PCHLinearGradient copy = new PCHLinearGradient();
		copy._startColor = _startColor;
		copy._endColor = _endColor;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public PCHLinearGradient() {
		_axis = XAXIS;
	}

	public PCHLinearGradient(color startColor, color endColor) {
		_startColor = startColor;
		_endColor = endColor;
		_axis = XAXIS;
	}

	public int axis() {
		return _axis;
	}

	public PCHLinearGradient setAxis(int axis) {
		_axis = axis;

		return this;
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		if (_axis == XAXIS) {
			for (int i = 0; i <= _width; i++) {
				HPath line = new HPath();

				float inter = H.app().map(i, 0, _width, 0, 1);
				color c = H.app().lerpColor(_startColor, _endColor, inter);

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
				color c = H.app().lerpColor(_startColor, _endColor, inter);

				g.stroke(c);
				g.strokeCap(SQUARE);
				g.strokeWeight(3);
				g.line(drawX, drawY+i, drawX+_width, drawY+i);
		    }
		}
	}
}