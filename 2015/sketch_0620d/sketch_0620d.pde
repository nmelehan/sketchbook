BlueCellGrid blueCellGrid;
PCHLazyDrawable lazyBlueCellGrid;

int copyIndex = 1;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	blueCellGrid = new BlueCellGrid();
	blueCellGrid.size(100, height).alpha(255);
	lazyBlueCellGrid = new PCHLazyDrawable(blueCellGrid);
	H.add(lazyBlueCellGrid);
}

void draw() {
	H.drawStage();

	// if (frameCount % 200 == 0) {
	// 	lazyBlueCellGrid.needsRender(true);
	// }
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



