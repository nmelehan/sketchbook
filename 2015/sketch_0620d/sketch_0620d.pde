BlueCellGrid blueCellGrid;
PCHLazyDrawable lazyBlueCellGrid;

void setup() {
	size(1280, 1280);
	H.init(this).background(#FFFFFF);

	blueCellGrid = new BlueCellGrid();
	blueCellGrid.size(width, height).alpha(255);
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
}



