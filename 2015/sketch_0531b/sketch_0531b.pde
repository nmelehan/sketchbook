PImage photo, maskImage;
PGraphics hcontext;

HDrawablePool pool;
HColorPool colors;

color sketchBackgroundColor = color(#202020);
int squareSize = 100;
int squareMargin = 5;
int gridDimensionWidth = 5;
int sketchMargin = 20;

void drawMask() {
  colors = new HColorPool()
    .add(#0095a8, 2)
    .add(#00616f, 2)
    .add(#FF3300)
    .add(#FF6600)
  ;

  pool = new HDrawablePool(gridDimensionWidth*gridDimensionWidth);
  pool
    .autoAddToStage()
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
}

void setup() {
  smooth();
  
  int sketchDimension = (squareSize+squareMargin)*gridDimensionWidth - squareMargin + sketchMargin*2;
  size(sketchDimension, sketchDimension);
  
  hcontext = createGraphics(sketchDimension, sketchDimension);
  hcontext.beginDraw();
  hcontext.smooth();
  hcontext.endDraw();

  H.init(this, hcontext).background(sketchBackgroundColor);
  
  drawMask();
  H.drawStage();
  photo = loadImage("lr.JPG");
  photo.mask(hcontext);
}

void draw() {
  //drawMask();
  //photo.mask(hcontext);
  image(photo, 0, 0);
}

void keyPressed() {
  drawMask();
  H.drawStage();
  photo.mask(hcontext);
}