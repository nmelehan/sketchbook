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

	HCanvas canvas = new HCanvas().autoClear(false).fade(50);
	H.add(canvas);

	HGroup hLines = new HGroup();
	canvas.add(hLines);

	final int numLines = 10;
	final HDrawablePool linesPool = new HDrawablePool(numLines);
	linesPool
		.autoParent(hLines)
		.add(new HPath())
		.colorist( new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600).strokeOnly() )

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HPath path = (HPath) obj;
					path.strokeWeight(4);
					int i = linesPool.currentIndex();
					path
						.vertex(0, (i+1)*height/(numLines+1))
						.vertex(width, (i+1)*height/(numLines+1));
				}
			}
		)

		.requestAll()
	;

	new HOscillator()
		.target(hLines)
		.property(H.Y)
		.range(-100, 100)
		.speed(1)
		.freq(2)
	;

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
        //canvas.add(ellG);

        HEllipse ellB = new HEllipse(40);
        ellB
          .loc(width/2, height/2)
          .anchorAt(H.CENTER)
          .noStroke()
          .fill(#0000FF)
          .alpha(100)
        ;
        //canvas.add(ellB);

        HEllipse ell = new HEllipse(40);
        ell
          .loc(width/2, height/2)
          .anchorAt(H.CENTER)
          .noStroke()
          .fill(#FFFFFF)
                      .alpha(155)
        ;
        //canvas.add(ell);

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
