PImage photo, maskImage;

void setup() {
  size(560, 560);
  
  photo = loadImage("lr.JPG");
  
  maskImage = loadImage("0531.PNG");
  maskImage.filter(THRESHOLD, 0.3);
  photo.mask(maskImage);
}

void draw() {
  image(photo, 0, 0);
}
