int sketchSize = 500;
int margin = 20;

color backgroundColor = color(225);
color accentColor = color(25);

void setup() {
	size(sketchSize, sketchSize);
	smooth();

	H.init(this).background(backgroundColor);

	H.add(new HRect()
		.rounding(10)
		.size(sketchSize-margin*2)
		.loc(margin, margin)
		.noStroke()
		.fill(accentColor)
	);

	HCanvas canvas = new HCanvas().autoClear(false).fade(500);
	H.add(canvas);

	/*HEllipse ellR = new HEllipse(40);
	ellR
		.loc(width/2, height/2)
		.anchorAt(H.CENTER)
		.noStroke()
		.fill(#FF0000)
                .alpha(100)
	;
	canvas.add(ellR);*/

        HEllipse ellG = new HEllipse(40);
        ellG
          .loc(width/2, height/2)
          .anchorAt(H.CENTER)
          .noStroke()
          .fill(#00FF00)
          .alpha(100)
        ;
        canvas.add(ellG);

        HEllipse ellB = new HEllipse(40);
        ellB
          .loc(width/2, height/2)
          .anchorAt(H.CENTER)
          .noStroke()
          .fill(#0000FF)
          .alpha(100)
        ;
        canvas.add(ellB);

        HEllipse ell = new HEllipse(40);
        ell
          .loc(width/2, height/2)
          .anchorAt(H.CENTER)
          .noStroke()
          .fill(#FFFFFF)
                      .alpha(155)
        ;
        canvas.add(ell);

	/*new HOscillator()
		.target(ellR)
		.property(H.X)
		.relativeVal(width/2)
		.range(-1*width/2 + margin, width/2 - margin)
		.speed(1)
		.freq(2)
	;*/

        new HOscillator()
          .target(ellG)
          .property(H.X)
          .relativeVal(width/2)
          .range(-1*width/2 + margin, width/2 - margin)
          .speed(1)
          .freq(2)
          .currentStep(.5)
        ;
      
        new HOscillator()
          .target(ellB)
          .property(H.X)
          .relativeVal(width/2)
          .range(-1*width/2 + margin, width/2 - margin)
          .speed(1)
          .freq(2)
          .currentStep(1)
        ;
      
        new HOscillator()
          .target(ell)
          .property(H.X)
          .relativeVal(width/2)
          .range(-1*width/2 + margin, width/2 - margin)
          .speed(1)
          .freq(2)
          .currentStep(1.5)
        ;
}

void draw() {
	H.drawStage();
}
