public static class PCHLinearGradient extends HDrawable {
	color _startColor, _endColor;

	public PCHLinearGradient createCopy() {
		PCHLinearGradient copy = new PCHLinearGradient();
		copy._startColor = _startColor;
		copy._endColor = _endColor;
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public PCHLinearGradient() {

	}

	public PCHLinearGradient setGradient() {
		// for (int i = 0; i <= _width; i++) {
		// 	HPath line = new HPath();

		// 	float inter = H.app().map(i, 0, _width, 0, 1);
		// 	color c = H.app().lerpColor(_startColor, _endColor, inter);
		// 	line
		// 		.stroke(c)
		// 		.strokeWeight(3);

		// 	line
		// 		.vertex(i, 0)
		// 		.vertex(i, _height);

		// 	this.add(line);
	 //    }

	    return this;
	}

	public PCHLinearGradient(color startColor, color endColor) {
		_startColor = startColor;
		_endColor = endColor;

		setGradient();
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
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
}