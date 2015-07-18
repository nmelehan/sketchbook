BlueCellGrid blueCellGrid;
PCHLazyDrawable lazyBlueCellGrid;

int copyIndex = 1;

PCHLightweightCanvas hlw;

int dIndex = 0;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	// blueCellGrid = new BlueCellGrid();
	// blueCellGrid.size(100, height).alpha(255);
	// lazyBlueCellGrid = new PCHLazyDrawable(blueCellGrid);
	// H.add(lazyBlueCellGrid);

	hlw = new PCHLightweightCanvas();
	hlw
		// .canvasAdditionRateLimit(60)
		.autoClear(false)
		.fade(10);
	H.add(hlw);
}

void generateTempRect(int x, int y) {
		int rectSize = 10;
		final HRect r = new HRect(rectSize, rectSize);
		r
			.loc((rectSize+0)*(dIndex%(width/rectSize)), (rectSize+0)*(dIndex/(width/rectSize)))
			.fill(0)
			.stroke(20);
		r.num("index", dIndex);
		dIndex++;
		HOscillator b = new HOscillator()
			.target(r)
			.property(H.ALPHA)
			.range(10, 20)
			.speed(1)
			.freq(4)
			.unregister();
		;
		int duration = 200;

		// HTween b = new HTween().target(r).property(H.ALPHA).start(0).end(255).ease(0.01).unregister();
		// b.callback(
		// 		new HCallback() {
		// 					public void run(Object obj) {
		// 						println("hello");
		// 						hlw.lightweightRemove(r);
		// 					}
		// 				}
		// 	);

		hlw.lightweightAdd(r, duration, b);
}

void draw() {
	if (frameCount % 1 == 0) {
		for (int i = 0; i < 1; i++)
			generateTempRect((int)random(width), (int)random(height));
	}

	H.drawStage();
}

void mouseClicked() {
	generateTempRect(mouseX, mouseY);
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	if (key == 'g') {
		lazyBlueCellGrid.needsRender(true);
	}
	if (key == 'c') {
		PCHLazyDrawable lazyBlueCellGridCopy = lazyBlueCellGrid.createCopy();
		lazyBlueCellGridCopy
			.loc(copyIndex*100, 0);
		H.add(lazyBlueCellGridCopy);

		copyIndex++;
	}
}



