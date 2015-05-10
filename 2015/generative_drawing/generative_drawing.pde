import codeanticode.tablet.*;

Tablet tablet;
Artist artist;
PGraphics canvas;

int sketchWidth = 500;
int sketchHeight = 500;

void setup() {
 size(sketchWidth, sketchHeight); 
  
 tablet = new Tablet(this); 
 artist = new Artist();
 canvas = createGraphics(250, 500);
}

void draw() {
  if (tablet.isMovement()) {
   strokeWeight(30 * tablet.getPressure());
    
    // Aside from tablet.getPressure(), which should be available on all pens, 
    // pen may support:
    //tablet.getTiltX(), tablet.getTiltY() MOST PENS
    //tablet.getSidePressure() - AIRBRUSH PEN
    //tablet.getRotation() - ART or PAINTING PEN    
    
    // The tablet getPen methods can be used to retrieve the pen current and 
    // saved position (requires calling tablet.saveState() at the end of 
    // draw())...
    //line(tablet.getSavedPenX(), tablet.getSavedPenY(), tablet.getPenX(), tablet.getPenY());
    
    // ...but it is equivalent to simply use Processing's built-in mouse 
    // variables.
    line(pmouseX, pmouseY, mouseX, mouseY);  
    Stroke stroke = new Stroke(tablet.getPenX(), tablet.getPenY(), tablet.getPressure());
    artist.drawStroke(stroke, canvas);
    image(canvas, 250, 0);
  }
}
