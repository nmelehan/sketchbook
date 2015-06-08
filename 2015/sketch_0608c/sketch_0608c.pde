int sketchSize = 500;
int margin = 20;

color backgroundColor = color(225);
color accentColor = color(25);

void setup() {
	size(sketchSize, sketchSize);
	smooth();

	H.init(this).background(backgroundColor);

	H.add(new HRect()
		.rounding(10)
		.size(sketchSize-margin*2)
		.loc(margin, margin)
		.noStroke()
		.fill(accentColor)
	);

	HCanvas canvas = new HCanvas().autoClear(false).fade(100);
	H.add(canvas);

	HEllipse ell = new HEllipse(40);
	ell
		.loc(width/2, height/2)
		.anchorAt(H.CENTER)
		.noStroke()
		.fill(backgroundColor)
	;
	canvas.add(ell);

	new HOscillator()
		.target(ell)
		.property(H.X)
		.relativeVal(width/2)
		.range(-1*width/2 + margin, width/2 - margin)
		.speed(1)
		.freq(2)
	;
}

void draw() {
	H.drawStage();
}
