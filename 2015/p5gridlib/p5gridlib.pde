SketchGrid grid;

int numRows = 8;
int numCols = 8;

int sketchWidth = 50;
int sketchHeight = 50;

void setup() {
  size(numCols*sketchWidth, numRows*sketchHeight);
  grid = new SketchGrid(this, new ShapeSketch(), numRows, numCols, sketchWidth, sketchHeight);
  grid.watchParameter("frequency", 1, 2);
}

void draw() {
  background(255);
  grid.draw();
}
