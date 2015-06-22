int canvasWidth = 400, canvasHeight = 700;
int sketchWidth = 800, sketchHeight = 800;

HRect boundingBox;
HCanvas canvas;

HPath quad() {
	float quadWidth = random(100, 200);
	float quadSide = random(50, 100);

	HPath quad = new HPath(POLYGON);
	quad
		.vertex(0, 0)
		.vertex(quadWidth, -1*quadWidth)
		.vertex(quadWidth, -1*quadWidth-quadSide)
		.vertex(0, -1*quadSide);

	return quad;
}

void setup() {
	size(sketchWidth, sketchHeight);
	H.init(this).background(#FFFFFF);

	canvas = H.add(new HCanvas(canvasWidth, canvasHeight));
	canvas
		.autoClear(false)
		.fade(3)
		.loc((sketchWidth-canvasWidth)/2, (sketchHeight-canvasHeight)/2);

	HRect boundingBox = H.add(new HRect(canvasWidth, canvasHeight));
	boundingBox
		.noFill()
		.stroke(#E35A27)
		.loc((sketchWidth-canvasWidth)/2, (sketchHeight-canvasHeight)/2);

	new HTimer(2000)
		.callback(new HCallback() {
			public void run(Object obj) {
				HPath quad = canvas.add(quad());

				quad
					.loc(-1*quad.width(), random(canvasHeight/3, 2*canvasHeight/3));

				new HFollow()
					.target(quad)
					.ease(.1)
					.goal(new HVector(canvasWidth/2-quad.width(), quad.y()-canvasWidth/2));
			}
		})
		;
}

boolean recording = false;
void draw() {
	H.drawStage();

	if (recording) {
		saveFrame();
	}
}

void keyPressed() {
	if (key == 'r') {
		recording = !recording;
	}
}
