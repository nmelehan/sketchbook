int sketchSize = 800;

color backgroundGradientOrange = #E86928;
color backgroundGradientYellow = #EDD425;
color middleGradientFillOrange = #D0491D;
color middleGradientFillYellow = #ECD425;
color middleGradientStrokeOrange = #E25527;
color middleGradientStrokeYellow = middleGradientFillYellow;
color bisectingLineYellow = #F8C928;
color bisectingLineYellow2 = #DDD922;

void setup() {
	H.init(this).background(255);

	size(sketchSize, sketchSize);

	H.add(new HRect(sketchSize/3, 2*sketchSize/3).loc(sketchSize/3, sketchSize/6));

	PCHLinearGradient backgroundGradient = new PCHLinearGradient(backgroundGradientOrange, backgroundGradientYellow);
	backgroundGradient
		.axis(PCHLinearGradient.YAXIS)
		.size(sketchSize/3, 2*sketchSize/3)
		.loc(sketchSize/3, sketchSize/6);
	H.add(backgroundGradient);

	PCHLinearGradient middleGradient = new PCHLinearGradient(middleGradientFillOrange, middleGradientFillYellow);
	middleGradient
		.axis(PCHLinearGradient.YAXIS)
		.size(sketchSize/12, 2*sketchSize/3)
		.loc(sketchSize/8, 0);
	backgroundGradient.add(middleGradient);

	PCHLinearGradient middleGradientStrokeLeft = new PCHLinearGradient(middleGradientStrokeOrange, middleGradientStrokeYellow);
	middleGradientStrokeLeft
		.axis(PCHLinearGradient.YAXIS)
		.size(2, 2*sketchSize/3);
	middleGradient.add(middleGradientStrokeLeft);

	HEllipse circleAccent = new HEllipse(sketchSize/6, sketchSize/6);
	circleAccent
		.loc(middleGradient.width()/2, 5*sketchSize/24)
		.anchorAt(H.CENTER)
		.stroke(bisectingLineYellow2)
		.strokeWeight(2)
		.noFill();
	middleGradient.add(circleAccent);

	PCHLinearGradient middleGradientStrokeRight = middleGradientStrokeLeft.createCopy();
	middleGradient.add(middleGradientStrokeRight).loc(middleGradient.width()-2, 0);
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
