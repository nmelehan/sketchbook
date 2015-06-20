
color originColor = color(126);
int canvasWidth = 400, canvasHeight = 700;

HRect boundingBox;
HDrawablePool pool;

HColorPool colorPool;

void polyAttr(HPath poly) {
	float length1 = random(25,75);
	float length2 = length1;
	float polyWidth = random(100, 200);
	float polyHeight = polyWidth;
	poly.clear();
	poly
		.vertex(0, 0)
		.vertex(length1, 0)
		.vertex(polyWidth, polyHeight-length2)
		.vertex(polyWidth, polyHeight)
		.vertex(polyWidth-length1, polyHeight)
		.vertex(0, length2)
		;

	poly.loc(random(0, canvasWidth-polyHeight), random(canvasHeight-polyHeight));

	poly
		.fill(colorPool.getColor())
		.stroke(255);
}

HPath poly() {
	HPath poly = new HPath(POLYGON);
	polyAttr(poly);

	return poly;
}

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	colorPool = new HColorPool(
		#DE2C32,
		#EB3925,
		#E66028,
		#FFB933,
		#FCF396,
		#FDEF12,
		#009FC1,
		#0085C3,
		#40908D,
		#69C7C6
		);

	boundingBox = H.add(new HRect(canvasWidth-100, canvasHeight-100));
	boundingBox
		.loc(250, 100)
		.noFill()
		.stroke(#dddddd)
		;

	final HCanvas canvas = H.add(new HCanvas(canvasWidth, canvasHeight).autoClear(false));
	canvas
		.loc(200, 50);

	final HPath poly = poly();
	canvas.add(poly);

	new HTimer(50)
		.callback(new HCallback() {
			public void run(Object obj) {
				polyAttr(poly);
			}
		})
		;
}

void draw() {
	H.drawStage();

	if (recording) saveFrame();
}

boolean recording = false;

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	else if (key == 'r') {
		recording = !recording;
	}
}
