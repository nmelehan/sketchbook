int canvasWidth = 400, canvasHeight = 700;
int sketchWidth = 800, sketchHeight = 800;

HRect boundingBox;
HCanvas canvas;

void setCourse(HDrawable d, HVelocity v) {
	float deg = random(360);
	d.rotate(deg);
	v.velocity(4, deg);
}

void generateGradient() {
	final PCHLinearGradient grad = new PCHLinearGradient(color(255, 0), #FCF396);
	grad
		.setAxis(PCHLinearGradient.YAXIS)
		.anchorAt(H.BOTTOM | H.RIGHT)
		.size(10, 75)
		.loc(canvasWidth/2, canvasHeight/2);
	canvas.add(grad);

	final HVelocity velo = new HVelocity().target(grad);
	setCourse(grad, velo);

	new HRandomTrigger(.1)
		.callback(new HCallback() {
			public void run(Object obj) {
				setCourse(grad, velo);
			}
		})
		;

	// new HTimer(10000, 1)
	// 	.callback(new HCallback() {
	// 		public void run(Object obj) {
	// 			grad.popOut();
	// 			velo.unregister();
	// 		}
	// 	})
	// 	;
}

void setup() {
	size(sketchWidth, sketchHeight);
	H.init(this).background(#FFFFFF);

	canvas = H.add(new HCanvas(canvasWidth, canvasHeight).autoClear(false));
	canvas
		.loc((sketchWidth-canvasWidth)/2, (sketchHeight-canvasHeight)/2);

	HRect boundingBox = H.add(new HRect(canvasWidth, canvasHeight));
	boundingBox
		.noFill()
		.stroke(#E35A27)
		.loc((sketchWidth-canvasWidth)/2, (sketchHeight-canvasHeight)/2);

	new HTimer(50)
		.callback(new HCallback() {
			public void run(Object obj) {
				generateGradient();
			}
		})
		;
}

boolean recording = true;
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
