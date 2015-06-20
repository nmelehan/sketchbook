color originColor = color(126);

HDrawable radial() {
	HEllipse ell = new HEllipse(.5);
	ell
		.noStroke()
		.fill(originColor)
		.loc(width/2, height/2)
		.anchorAt(H.CENTER)
		;

	HVelocity movement = new HVelocity()
		.velocity(1, random(360))
		.target(ell);

	return ell;
}

void setup() {
	size(400, 700);
	H.init(this).background(#FFFFFF);

	final HCanvas canvas = H.add(new HCanvas().autoClear(false));

	HTimer radialTrigger = new HTimer(50)
		.callback(new HCallback() {
			public void run(Object obj) {
				canvas.add(radial());
			}
		});
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
