int cursorWidth = 100;
int cursorHeight = (int)(100*1.62);

int sketchPadding = 100;
int sketchDimension = cursorHeight + sketchPadding*2;

void setup() {
	size(sketchDimension, sketchDimension);
	H.init(this).background(#171717);

	final HRect cursorRect = new HRect(cursorWidth, cursorHeight);
	cursorRect
		.rounding(2)
		.stroke(#d9d9d9)
		.fill(#333333)
		.anchorAt(H.CENTER)
		.loc(width/2, height/2)
		;
	HCanvas canvas = new HCanvas().autoClear(false).fade(4);
	canvas.add(cursorRect);
	H.add(canvas);

	HTimer timer = new HTimer(750)
		.callback(new HCallback() {
				public void run (Object obj) {
					if (cursorRect.alpha() == 0) {
						cursorRect.alpha(255);
					} else {
						cursorRect.alpha(0);
					}
				} // end -- run()
			}) // end -- new HCallback()
		;

	// HOscillator osc = new HOscillator()
	// 	.target(cursorRect)
	// 	.property(H.DX)
	// 	.range(-3, 3)
	// 	.currentStep(90)
	// 	.speed(10)
	// 	;
}

void draw() {
	H.drawStage();
}