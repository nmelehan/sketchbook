int sketchSize = 800;

color backgroundGradientOrange = #E86928;
color backgroundGradientYellow = #EDD425;
color middleGradientFillOrange = #D0491D;
color middleGradientFillYellow = #ECD425;
color middleGradientStrokeOrange = #E25527;
color middleGradientStrokeYellow = middleGradientFillYellow;
color bisectingLineYellow = #F8C928;
color bisectingLineYellow2 = #DDD922;

HDrawablePool linePool;
HCanvas boundingBox;

void setup() {
	H.init(this).background(255).autoClear(false);

	size(sketchSize, sketchSize);


	boundingBox = new HCanvas(sketchSize/3, 2*sketchSize/3).autoClear(false);
	boundingBox.loc(sketchSize/3, sketchSize/6);
	H.add(boundingBox);

	linePool = new HDrawablePool(5)
		.autoParent(boundingBox)
		.add(new HRect())
		.onCreate(new HCallback() {
				public void run(Object obj) {
					parameterizeLine((HRect)obj);
				}
			})
		.requestAll()
		;

	// PCHLinearGradient backgroundGradient = new PCHLinearGradient(backgroundGradientOrange, backgroundGradientYellow);
	// backgroundGradient
	// 	.axis(PCHLinearGradient.YAXIS)
	// 	.size(sketchSize/3, 2*sketchSize/3)
	// 	.loc(sketchSize/3, sketchSize/6);
	// H.add(backgroundGradient);

	// PCHLinearGradient middleGradient = new PCHLinearGradient(middleGradientFillOrange, middleGradientFillYellow);
	// middleGradient
	// 	.axis(PCHLinearGradient.YAXIS)
	// 	.size(sketchSize/12, 2*sketchSize/3)
	// 	.loc(sketchSize/8, 0);
	// backgroundGradient.add(middleGradient);

	// PCHLinearGradient middleGradientStrokeLeft = new PCHLinearGradient(middleGradientStrokeOrange, middleGradientStrokeYellow);
	// middleGradientStrokeLeft
	// 	.axis(PCHLinearGradient.YAXIS)
	// 	.size(2, 2*sketchSize/3);
	// middleGradient.add(middleGradientStrokeLeft);

	// PCHLinearGradient middleGradientStrokeRight = middleGradientStrokeLeft.createCopy();
	// middleGradient.add(middleGradientStrokeRight).loc(middleGradient.width()-2, 0);
}

void parameterizeLine(HRect line) {
	PVector loc = new PVector(random(boundingBox.width()), random(boundingBox.height()));
	float inter = map(loc.y + random(-50, 50), 0, boundingBox.height(), 0, 1);
	color c = lerpColor(backgroundGradientOrange, backgroundGradientYellow, inter);

	line
		.width((boundingBox.width() - loc.x) * random(.2, 1))
		.height(1)
		.stroke(c)
		.noFill()
		.loc(loc)
	;
}

void draw() {
	H.drawStage();

	for (HDrawable d : linePool) {
		parameterizeLine((HRect)d);
	}
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}
