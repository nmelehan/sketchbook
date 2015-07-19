BlueCellGrid bcg;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	bcg = new BlueCellGrid(width, height);
	H.add(bcg);
}

void draw() {
	H.drawStage();
}

void mouseClicked() {
	H.clearStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}



