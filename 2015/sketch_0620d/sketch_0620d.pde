BlueCellGrid bcg;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	bcg = new BlueCellGrid(width/2, height/2);
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

void mouseMoved() {
	if (mouseX > 0 && mouseY > 0)
		bcg.size(mouseX, mouseY);
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}



