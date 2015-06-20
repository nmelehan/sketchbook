void cell(HRect d) {
	HDrawablePool pool = new HDrawablePool(25)
		.autoParent(d)
		.add(new HRect(8, 8))
		.layout(
			new HGridLayout()
				.startX(1)
				.startY(1)
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
		.loc(200, 50);

	HDrawablePool pool = new HDrawablePool(112)
		.autoParent(boundingBox)
		.add(new HRect(46, 46))
		.layout(
			new HGridLayout()
				.startX(2)
				.startY(2)
				.spacingX(50)
				.spacingY(50)
				.cols(8)
		)
		.onCreate(new HCallback() {
			public void run(Object obj) {
				HRect d = (HRect)obj;
				cell(d);
			}
		})
		.requestAll();
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
