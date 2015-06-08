HDrawablePool shapePool;

int quadMargin = 25;
int sketchSize = 750;
color sketchBackgroundColor = color(225);
color quadStrokeColor = color(225);
int quadStrokeWeight = 10;
int quadStrokeJoin = ROUND;

void setup() {
	size(sketchSize, sketchSize);
	H.init(this).background(sketchBackgroundColor).autoClears(true);
	drawPattern();
}

void draw() {
	H.drawStage();
}

void assignVertices(HPath quadrilateral) {
	quadrilateral
		.clear()
		.vertex(quadMargin, quadMargin)
		.vertex(width-quadMargin, quadMargin)
		.vertex(width-quadMargin, random(quadMargin, height-quadMargin))
		.vertex(quadMargin, random(0, height-quadMargin))
	;
}

void drawPattern() {
	if (shapePool == null) {
		final HColorPool colors = new HColorPool()
			.add(#FF6138)
			.add(#FFFF9D)
			.add(#BEEB9F)
			.add(#79BD8F)
			.add(#00A388)
		;

		HCanvas canvas = new HCanvas()
			.autoClear(true);
		H.add(canvas);

		canvas.add(
				new HRect()
					.size(width-quadMargin*2)
					.loc(quadMargin, quadMargin)
					.noStroke()
					.fill(50)
			);

		shapePool = new HDrawablePool(10)
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
							assignVertices(d);	

							d
								.stroke(quadStrokeColor)
								.strokeWeight(quadStrokeWeight)
								.strokeJoin(quadStrokeJoin)
								.fill( colors.getColor() )
								.anchorAt(H.TOP | H.LEFT)
								.loc(0, 0)
							;
						} // end -- run()
					} // end -- new HCallBack()
				) // end -- onCreate()

			.requestAll()
		; // end -- new HDrawablePool()
	} // end if

	else {
		for (HDrawable d : shapePool) {
			assignVertices((HPath)d);
		}
	} // end else
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	else {
		drawPattern();
	}
}
