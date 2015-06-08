HDrawablePool shapePool;

int quadMargin = 25;
int sketchSize = 750;
color sketchBackgroundColor = color(250);
color quadStrokeColor = color(50);
int quadStrokeWeight = 5;
int quadStrokeJoin = ROUND;
int sizeOfPool = 7;

float maxDistance = 200, minDistance = 25;

ColorPoolCollection cpc;

void setup() {
	size(sketchSize, sketchSize);

	cpc = new ColorPoolCollection();

	H.init(this).background(sketchBackgroundColor).autoClears(true);
	drawPattern();
}

void draw() {
	minDistance = mouseX/5;
	maxDistance = max(mouseX, mouseY)/5;

	H.drawStage();
}

void assignColors(HDrawablePool shapePool) {
	for (HDrawable d : shapePool) {
		d.fill (cpc.getColor());
	}
}

void assignVertices(HDrawablePool shapePool) {
	float bl = quadMargin, br = quadMargin;

	for (HDrawable d : shapePool) {
		HPath quadrilateral = (HPath)d;

		bl = random(min(bl+minDistance, height-quadMargin), min(bl+maxDistance, height-quadMargin));
		br = random(min(br+minDistance, height-quadMargin), min(br+maxDistance, height-quadMargin));

		quadrilateral
			.clear()
			.vertex(quadMargin, quadMargin)
			.vertex(width-quadMargin, quadMargin)
			.vertex(width-quadMargin, br)
			.vertex(quadMargin, bl)
		;
	}
}

void drawPattern() {
	if (shapePool == null) {
		// background square
		int numLinesInGrid = 20;
		color lineStrokeColor = 200;
		for (int i = 1; i < numLinesInGrid; i++) {
			H.add(
				new HPath()
					.vertex(quadMargin+i*(width-quadMargin*2)/numLinesInGrid, quadMargin)
					.vertex(quadMargin+i*(width-quadMargin*2)/numLinesInGrid, height-quadMargin)
					.stroke(lineStrokeColor)
					.strokeWeight(1)
			);
		}
		for (int i = 1; i < numLinesInGrid; i++) {
			H.add(
				new HPath()
					.vertex(quadMargin, quadMargin+i*(height-quadMargin*2)/numLinesInGrid)
					.vertex(width-quadMargin, quadMargin+i*(height-quadMargin*2)/numLinesInGrid)
					.stroke(lineStrokeColor)
					.strokeWeight(1)
			);
		}

		H.add(
			new HRect()
				.rounding(10)
				.size(width-quadMargin*2)
				.loc(quadMargin, quadMargin)
				.stroke(quadStrokeColor)
				.strokeWeight(2)
				.noFill()
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
								.fill( cpc.getColor() )
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
	else if (key == 'c') {
		assignColors(shapePool);
	}
	else if (key == 'a') {
		cpc.advancePool();
		assignColors(shapePool);
	}
	else {
		assignVertices(shapePool);
	}
}
