SketchGrid grid;

int numRows = 4;
int numCols = 4;

int sketchWidth = 50;
int sketchHeight = 50;

void setup() {
  size(numCols*sketchWidth, numRows*sketchHeight);
  grid = new SketchGrid(this, new ShapeSketch(), numRows, numCols, sketchWidth, sketchHeight);
  grid.watchParameter("frequency", 1, 8);
  grid.watchParameter("ellipseRadius", 5, 15);
  grid.watchParameter("orbitRadius", 15, 5);
}

void draw() {
  background(255);
  grid.draw();
  int frameSkip = 3;
  if (frameCount%frameSkip == 0 && frameCount < frameSkip*200) {
    saveFrame("gif-####.gif");
  } else if (frameCount >= 1000) {
    textSize(18);
    fill(0);
    text("gif saved", width/2, height/2);
  }
}
