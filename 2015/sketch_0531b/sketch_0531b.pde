PImage photo, maskImage;
PGraphics hcontext;
PGraphics hcanvascontext;

HDrawablePool pool;
HColorPool colors;

HCanvas hcanvas;

boolean drawPhoto = true;

//color sketchBackgroundColor = color(0, 0, 0);
color sketchBackgroundColor = color(255, 255, 255);
int squareSize = 100;
int squareMargin = 5;
int gridDimensionWidth = 5;
int sketchMargin = 20;

int sketchDimension() {
	return (squareSize+squareMargin)*gridDimensionWidth - squareMargin + sketchMargin*2;
}

/*void drawMask() {
  hcanvas.add(new HRect(sketchDimension(), sketchDimension()).fill(sketchBackgroundColor).loc(0,0));

  colors = new HColorPool()
    .add(#0095a8, 2)
    .add(#00616f, 2)
    .add(#FF3300)
    .add(#FF6600)
  ;

  pool = new HDrawablePool(gridDimensionWidth*gridDimensionWidth);
  pool
    .autoParent(hcanvas)
    .add (
      new HRect(squareSize)
      .rounding(2)
      .fill(#FFFFFF)
    )

    .layout (
      new HGridLayout()
      .startX(sketchMargin)
      .startY(sketchMargin)
      .spacing(squareSize+squareMargin, squareSize+squareMargin)
      .cols(gridDimensionWidth)
    )

    .onCreate (
       new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable) obj;
          d
            .noStroke()
            .anchorAt(H.TOP | H.LEFT)
          ;
          
          for (int i = 0; i < (int)random(5); i++) {
            HPath line = new HPath();
            line
              .vertex(0,(int)random(squareSize))
              .vertex(squareSize, (int)random(squareSize))
            ;
            line.noFill()
              .strokeWeight(4)
              .stroke(sketchBackgroundColor)
            ;
            d.add(line);
          } // end -- for loop
        } // end -- run()
      } // end -- HCallback()
    ) // end -- pool.onCreate()

    .requestAll()
  ; // end -- pool.
}*/

void drawMask() {
	//hcanvas.add(new HRect(sketchDimension(), sketchDimension()).fill(sketchBackgroundColor).loc(0,0));

  	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333);

	pool = new HDrawablePool(400);
	pool.autoParent(hcanvas)
		.add(
			new HRect(50)
			.rounding(20)
			.anchorAt(H.CENTER)
			.noStroke()
		)

		.layout(
			new HGridLayout()
			.startLoc(0, height/2)
			.spacing(1, 0)
			.cols(400)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HDrawable d = (HDrawable) obj;
					d.fill( colors.getColor(i*100) );

					new HOscillator()
						.target(d)
						.property(H.X)
						.relativeVal(d.x())
						.range(-300, 300)
						.speed(1)
						.freq(0.5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(d.y())
						.range(-300, 300)
						.speed(2)
						.freq(0.7)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(0, 360)
						.speed(0.001)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0, 2)
						.speed(1)
						.freq(4)
						.currentStep(i)
					;
				}
			}
		)

		.requestAll()
	;
}

void setup() {
  size(sketchDimension(), sketchDimension());
  
  hcontext = createGraphics(sketchDimension(), sketchDimension());
  hcontext.beginDraw();
  hcontext.endDraw();

  H.init(this, hcontext).background(255);

  hcanvas = new HCanvas().autoClear(true);
  H.add(hcanvas);

  drawMask();
 
  photo = loadImage("lr.JPG");
}

void draw() {
  H.drawStage();
  background(255, 0, 0);
  photo.mask(hcontext);

  if (drawPhoto) 
  	image(photo, 0, 0);
  else 
  	image(hcontext, 0, 0);
}

void keyPressed() {
	drawPhoto = !drawPhoto;
}