import codeanticode.tablet.*;
import controlP5.*;

ControlP5 cp5;

int col = color(255);

boolean toggleValue = false;

Tablet tablet;
Artist artist;

int controlPanelWidth = 25;

int canvasWidth = 500;
int canvasHeight = 500;

int controlPanelGap = 10;
int sketchPadding = 10;

int sketchWidth = sketchPadding*2+controlPanelWidth+controlPanelGap+canvasWidth;
int sketchHeight = sketchPadding*2+canvasHeight;

void setup() {
 size(sketchWidth, sketchHeight); 
 
 H.init(this).background(#202020);
  
 tablet = new Tablet(this); 
 artist = new Artist();
 artist.hcanvas.size(canvasWidth, canvasHeight);
 artist.hcanvas.loc(sketchPadding+controlPanelGap+controlPanelWidth, sketchPadding);
 
  smooth();
  cp5 = new ControlP5(this);
  
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addButton("clearCanvas")
     .setPosition(sketchPadding,sketchPadding)
     .setSize(controlPanelWidth,controlPanelWidth)
     .setLabelVisible(false)
     ;
}

void drawLayout() {
  strokeWeight(1);
  stroke(25);
  noFill();
  
  rect(sketchPadding+controlPanelGap+controlPanelWidth, sketchPadding, canvasWidth, canvasHeight);
}

float mouseXToCanvasX(float x) {
  return x-(sketchPadding+controlPanelGap+controlPanelWidth);
}

float mouseYToCanvasY(float y) {
  return y-sketchPadding;
}

void draw() {
  if (tablet.isMovement()) {
   strokeWeight(3 * tablet.getPressure());
    line(pmouseX, pmouseY, mouseX, mouseY);  
    Stroke stroke = new Stroke(mouseXToCanvasX(tablet.getPenX()), mouseYToCanvasY(tablet.getPenY()), tablet.getPressure());
    artist.addStroke(stroke);
  }
  
  drawLayout();
  
  H.drawStage();
}

boolean sketchFullScreen() {
  return true;
}

void clearCanvas(){
   artist.clearCanvas();
}
