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
		.canvasAdditionRateLimit(5)
		.autoClear(false)
		.fade(10);
	H.add(hlw);
}

void generateTempRect(int x, int y) {
		int rectSize = 10;
		final HRect r = new HRect(rectSize, rectSize);
		r
			.loc((rectSize+10)*(dIndex%(width/rectSize)), (rectSize+10)*(dIndex/(width/rectSize)))
			.fill(0)
			.stroke(20)
			.alpha(0)
			;
		r.num("index", dIndex);
		dIndex++;
		// HOscillator b = new HOscillator()
		// 	.target(r)
		// 	.property(H.ALPHA)
		// 	.range(10, 20)
		// 	.speed(1)
		// 	.freq(4)
		// 	.unregister();
		// ;
		int duration = 200;

		final PCHLightweightCanvasBinding binding = new PCHLightweightCanvasBinding(r);
		binding.delayCycleCountDown(true);

		HTween b = new HTween().target(r).property(H.ALPHA).start(0).end(255).ease(0.1).unregister();
		b.callback(
				new HCallback() {
						public void run(Object obj) {
							println(binding.drawable().num("index"));
							binding.delayCycleCountDown(false);
						}
					}
			);

		binding.behavior(b);

		hlw.lightweightAdd(binding);
}

void draw() {
	if (frameCount % 1 == 0) {
		for (int i = 0; i < 20; i++)
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



