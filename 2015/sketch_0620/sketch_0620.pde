color originColor = color(126);
void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF).autoClear(false);

        HRect rect = new HRect(1, 1);
        rect
          .fill(originColor)
          .noStroke()
          .loc(100, 100);
        H.add(rect);
}

float angle = 100;
float speed = 5;

void draw() {
        //if (random(1) > .8)
        //rect.move(5*cos(angle), 5*sin(angle));
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
