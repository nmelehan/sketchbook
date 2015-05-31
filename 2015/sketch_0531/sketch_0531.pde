HDrawablePool pool;
HColorPool colors;

void setup() {
  final color sketchBackgroundColor = color(#202020);
  
  final int squareSize = 100;
  final int squareMargin = 5;
  final int gridDimensionWidth = 5;
  final int sketchMargin = 20;
  
  int sketchDimension = (squareSize+squareMargin)*gridDimensionWidth - squareMargin + sketchMargin*2;
  
  size(sketchDimension, sketchDimension);
  H.init(this).background(sketchBackgroundColor);
  smooth();

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

void draw() {
  H.drawStage();
}

