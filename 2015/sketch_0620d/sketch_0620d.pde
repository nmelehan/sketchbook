// void cell(HDrawable d) {
// 	HDrawablePool pool = new HDrawablePool(25)
// 		.autoParent(d)
// 		.add(new HRect(3, 3)
// 			.fill(#ffffff)
// 			.noStroke()
// 			.alpha(100))
// 		.layout(
// 			new HGridLayout()
// 				.startX(1)
// 				.startY(1)
// 				.spacingX(3.75)
// 				.spacingY(3.75)
// 				.cols(5)
// 		)
// 		.requestAll();
// }

// PCHLinearGradient backgroundGrad;

// color startColor = #54C9F4;
// color endColor = #A6E2FC;

// HRect cellRect;
// float tweenEase = .2;

// void locateCell(HRect cellRect) {
// 	int cellRow = cellRect.numI("currentCellRow");
// 	int cellCol = cellRect.numI("currentCellColumn");

// 	cellRect.loc(cellCol * 3.75, cellRow * 3.75);

// 	cellCol = cellCol < 4 ? cellCol + 1 : 0;
// 	cellRow = cellCol == 0 ? cellRow + 1 : cellRow;
// 	//if (cellRow < 20) {
// 		cellRect.num("currentCellRow", cellRow);
// 		cellRect.num("currentCellColumn", cellCol);
// 	//}
// }

// HCanvas cellCanvas;

// void renderCellGrid() {
// 	cellRect = new HRect(3, 3);
// 	cellRect
// 			.fill(0)
// 			.noStroke()
// 			.alpha(100);
// 	cellRect.num("currentGridRow", 0);
// 	cellRect.num("currentGridColumn", 0);
// 	cellRect.num("currentCellRow", 0);
// 	cellRect.num("currentCellColumn", 0);
// 	cellCanvas.add(cellRect);

// 	locateCell(cellRect);
// }

HPath star;
PCHLazyDrawable lazyStar;

HRect boundingBox;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	star = new HPath();
	star.star( 5, 0.3 ).size(150,150).strokeWeight(6).stroke(#000000, 100).fill(#FF9900).loc(250, 250);
	// H.add(star);

	lazyStar = new PCHLazyDrawable(star);
	H.add(lazyStar);

	H.add(boundingBox = new HRect().rounding(10))
		.strokeWeight(2)
		.stroke(#FF3300)
		.noFill()
	;

	PVector loc = new PVector(), size = new PVector();
	star.bounds(loc,size);
	boundingBox.loc(loc.x,loc.y).size(size.x,size.y);
}

void draw() {
	H.drawStage();
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



