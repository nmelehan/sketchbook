
color originColor = color(126);
int canvasWidth = 400, canvasHeight = 700;

HRect boundingBox;
HDrawablePool pool;

HPath poly() {
	HPath poly = new HPath(POLYGON);
	float length1 = random(50);
	float length2 = random(50);
	float polyWidth = random(100, 400);
	float polyHeight = random(150, 400);
	poly
		.vertex(0, 0)
		.vertex(length1, 0)
		.vertex(polyWidth, polyHeight-length2)
		.vertex(polyWidth, polyHeight)
		.vertex(polyWidth-length1, polyHeight)
		.vertex(0, length2)
		;

	return poly;
}

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	boundingBox = H.add(new HRect(canvasWidth, canvasHeight));
	boundingBox
		.loc(200, 50)
		.noFill()
		.stroke(#dddddd)
		;

	final HCanvas canvas = H.add(new HCanvas().autoClear(false));
	canvas
		.loc(200, 50);

	new HTimer(50)
		.callback(new HCallback() {
			public void run(Object obj) {
				canvas.add(poly());
			}
		})
		;
}

void draw() {
	H.drawStage();

	if (recording) saveFrame();
}

boolean recording = true;

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	else if (key == 'r') {
		recording = !recording;
	}
}
