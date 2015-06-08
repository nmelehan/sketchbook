HDrawablePool shapePool;

int quadMargin = 25;
int sketchSize = 750;
color sketchBackgroundColor = color(225);
color quadStrokeColor = color(25);
int quadStrokeWeight = 20;
int quadStrokeJoin = ROUND;
int sizeOfPool = 7;

float maxDistance = 200, minDistance = 25;

HColorPool colors = new HColorPool()
			.add(#FF6138)
			.add(#FFFF9D)
			.add(#BEEB9F)
			.add(#79BD8F)
			.add(#00A388)
		;

void setup() {
	size(sketchSize, sketchSize);
	H.init(this).background(sketchBackgroundColor).autoClears(true);
	drawPattern();
}

void draw() {
	minDistance = mouseX/5;
	maxDistance = max(mouseX, mouseY)/5;

	H.drawStage();
}

void assignVertices(HDrawablePool shapePool) {
	float bl = quadMargin, br = quadMargin;

	for (HDrawable d : shapePool) {
		HPath quadrilateral = (HPath)d;

		d.fill (colors.getColor());

		bl = random(min(bl+minDistance, height-quadMargin), min(bl+maxDistance, height-quadMargin));
		br = random(min(br+minDistance, height-quadMargin), min(br+maxDistance, height-quadMargin));

		println(bl);
		quadrilateral
			.clear()
			.vertex(quadMargin, quadMargin)
			.vertex(width-quadMargin, quadMargin)
			.vertex(width-quadMargin, br)
			.vertex(quadMargin, bl)
		;
	}
	println();
}

void drawPattern() {
	if (shapePool == null) {
		H.add(
			new HRect()
				.rounding(10)
				.size(width-quadMargin*2)
				.loc(quadMargin, quadMargin)
				.noStroke()
				.fill(50)
		);

		HCanvas canvas = new HCanvas()
			.autoClear(true);
		H.add(canvas);


		shapePool = new HDrawablePool(sizeOfPool)
				.autoParent(canvas)
				.add (
					new HPath(POLYGON)
				)

				// .layout(
				// 	new HGridLayout()
				// 		.startX(0)
				// 		.startY(0)
				// 		.spacing(26,26)
				// 		.cols(1)
				// )

				.onCreate (
					 new HCallback() {
						public void run(Object obj) {
							HPath d = (HPath) obj;	

							d
								.stroke(quadStrokeColor)
								.strokeWeight(quadStrokeWeight)
								.strokeJoin(quadStrokeJoin)
								.fill( colors.getColor() )
								.anchorAt(H.TOP | H.LEFT)
								.loc(0, 0)
							;

							d.putBefore(d.parent().firstChild());
						} // end -- run()
					} // end -- new HCallBack()
				) // end -- onCreate()

			.requestAll()
		; // end -- new HDrawablePool()
	} // end if

	assignVertices(shapePool);
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	else {
		drawPattern();
	}
}
