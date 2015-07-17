BlueCellGrid blueCellGrid;
PCHLazyDrawable lazyBlueCellGrid;

int copyIndex = 1;

PCHLightweightCanvas hlw;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	// blueCellGrid = new BlueCellGrid();
	// blueCellGrid.size(100, height).alpha(255);
	// lazyBlueCellGrid = new PCHLazyDrawable(blueCellGrid);
	// H.add(lazyBlueCellGrid);

	hlw = new PCHLightweightCanvas();
	hlw.autoClear(false).fade(10);
	H.add(hlw);
}

void generateTempRect(int x, int y) {
		HRect r = new HRect(50, 50);
		r.loc(x, y);
		HOscillator b = new HOscillator()
			.target(r)
			.property(H.SIZE)
			.range(10, 100)
			.speed(1)
			.freq(4)
			.unregister();
		;
		hlw.lightweightAdd(r, 1000, b);
}

void draw() {
	if (frameCount % 10 == 0) {
		generateTempRect((int)random(width), (int)random(height));
	}

	H.drawStage();

	// if (frameCount % 200 == 0) {
	// 	lazyBlueCellGrid.needsRender(true);
	// }
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



