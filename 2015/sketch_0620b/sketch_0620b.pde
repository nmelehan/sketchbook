color originColor = color(126);

HDrawable radial() {
	final HEllipse ell = new HEllipse();
	ell
		.radius(1)
		.noStroke()
		.fill(originColor)
		.loc(width/2, height/2)
		.anchor(0, floor(random(height/2/3) + 1)*10)
		;

	float speed = random(1) > .5 ? 2 : -2;
	HRotate ellRotate = new HRotate()
		.target(ell)
		.speed(speed)
		;

	HTimer timer = new HTimer(360/2)
		.callback(new HCallback() {
			public void run(Object obj) {
				ell.fill((int)random(255));
			}
		});

	return ell;
}

void setup() {
	smooth();
	size(400, 700);
	H.init(this).background(#FFFFFF);

	final HCanvas canvas = H.add(new HCanvas().autoClear(false));

	canvas.add(radial());

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

