color originColor = color(126);
int canvasWidth = 400, canvasHeight = 700;

HRect boundingBox;
HDrawablePool pool;

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

void radialPool() {
	boundingBox = new HRect(canvasWidth, canvasHeight);
	boundingBox
		.loc(200, 50)
		.noFill()
		.stroke(originColor)
		;
	H.add(boundingBox);

	final HCanvas canvas = H.add(new HCanvas(400, 700).autoClear(false));
	canvas.loc(200, 50);

	pool = new HDrawablePool(5)
		.autoParent(canvas)
		.add(new HEllipse(.5))
		.onCreate(new HCallback() {
			public void run(Object obj) {
				HDrawable d = (HDrawable)obj;
				d
					.noStroke()
					.fill(originColor)
					.loc(canvasWidth/2, canvasHeight/2)
					.anchorAt(H.CENTER)
					;

				final HVelocity movement = new HVelocity()
					.velocity(1, random(360))
					.target(d);

				new HRandomTrigger(.1)
					.callback(new HCallback() {
						public void run(Object obj) {
							movement.velocity(1, random(360));
						}
					})
					;
			}
		})
		;

	new HTimer(50)
		.callback(new HCallback() {
			public void run(Object obj) {
				pool.request();
			}
		})
		;
}

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	radialPool();
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
