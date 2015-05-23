import codeanticode.tablet.*;
import controlP5.*;

ControlP5 cp5;

int col = color(255);

boolean toggleValue = false;

Tablet tablet;
Artist artist;

int controlPanelWidth = 200;

int canvasWidth = 1000;
int canvasHeight = 1000;

int controlPanelGap = 10;
int sketchPadding = 10;

int sketchWidth = sketchPadding*2+controlPanelWidth+controlPanelGap+canvasWidth;
int sketchHeight = sketchPadding*2+canvasHeight;

void setup() {
 size(sketchWidth, sketchHeight); 
  
 tablet = new Tablet(this); 
 artist = new Artist();
 artist.setCanvasSize(canvasWidth, canvasHeight);
 
  smooth();
  cp5 = new ControlP5(this);
  
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addButton("drawHistory")
     .setPosition(sketchPadding,sketchPadding)
     .setSize(controlPanelWidth,controlPanelWidth)
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
  image(artist.getCanvas(), sketchPadding+controlPanelGap+controlPanelWidth, sketchPadding);
}

boolean sketchFullScreen() {
  return true;
}

void drawHistory(){
   artist.drawHistory();
}
