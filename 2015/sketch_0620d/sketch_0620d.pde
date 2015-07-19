BlueCellGrid bcg;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	bcg = new BlueCellGrid(width, height);
	H.add(bcg);
}

void draw() {
	bcg.render();

	H.drawStage();
}

void mouseClicked() {
	H.clearStage();
	bcg.init();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}



