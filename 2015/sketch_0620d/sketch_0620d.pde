BlueCellGrid blueCellGrid;
PCHLazyDrawable lazyBlueCellGrid;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	blueCellGrid = new BlueCellGrid();
	blueCellGrid.size(800, 800).alpha(255);
	lazyBlueCellGrid = new PCHLazyDrawable(blueCellGrid);
	H.add(lazyBlueCellGrid);

	// new HRotate().target(lazyBlueCellGrid).speed(1);
}

void draw() {
	H.drawStage();

	if (frameCount % 200 == 0) {
		lazyBlueCellGrid.needsRender(true);
	}
}

// void keyPressed() {
// 	if (key == 'p') {
// 		saveFrame();
// 	}
// 	if (key == 'c') {
// 		for (HDrawable child : markerGroup) {
// 			markerGroup.remove(child);
// 		}
// 	}
// 	if (key == 'g') {
// 		// markerGroup.add(darkMarkSeries());
// 	}
// 	if (key == 's') {
// 		// for (int i = 0; i < 10+random(10); i++) {
// 		// 	markerGroup.add(darkMarkSeries());
// 		// }
// 	}
// }



