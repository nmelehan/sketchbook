SketchGrid grid;

void setup() {
  size(200, 200);
  grid = new SketchGrid(this, new ShapeSketch());
}

void draw() {
  background(255);
  grid.draw();
}
