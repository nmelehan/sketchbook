void cell(HDrawable d) {
	HDrawablePool pool = new HDrawablePool(25)
		.autoParent(d)
		.add(new HRect(8, 8)
			.noStroke()
			.alpha(100))
		.layout(
			new HGridLayout()
				.startX(2)
				.startY(2)
				.spacingX(9)
				.spacingY(9)
				.cols(5)
		)
		.requestAll();
}

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	HRect boundingBox = H.add(new HRect(400, 700));
	boundingBox
		.loc(200, 50)
		.fill(#008EC3)
		.noStroke();

	// HDrawablePool pool = new HDrawablePool(112)
	// 	.autoParent(boundingBox)
	// 	.add(new HGroup())
	// 	.layout(
	// 		new HGridLayout()
	// 			.startX(2)
	// 			.startY(2)
	// 			.spacingX(50)
	// 			.spacingY(50)
	// 			.cols(8)
	// 	)
	// 	.onCreate(new HCallback() {
	// 		public void run(Object obj) {
	// 			HGroup d = (HGroup)obj;
	// 			cell(d);
	// 		}
	// 	})
	// 	.requestAll();

	PCHLinearGradient grad = new PCHLinearGradient(#A6E2FC, #0783BE);
	H.add(grad);
	grad
		.size(700, 400)
		.loc(width/2, height/2)
		.anchorAt(H.CENTER)
		.rotate(-90)
		;
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
