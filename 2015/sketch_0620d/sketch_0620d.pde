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

void draw() {
	if (frameCount % 10 == 0) {
		hlw.lightweightAdd(new HRect(50, 50).loc(random(width), random(height)), 1000);
	}

	H.drawStage();

	// if (frameCount % 200 == 0) {
	// 	lazyBlueCellGrid.needsRender(true);
	// }
}

void mouseClicked() {
	hlw.lightweightAdd(new HRect(50, 50).loc(mouseX, mouseY), 10000);
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



