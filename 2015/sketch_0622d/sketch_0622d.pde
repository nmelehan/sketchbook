class Point {
  float _x, _y;

  public Point(float anX, float aY) {
    _x = anX;
    _y = aY;
  }

  float x() {
    return _x;
  }

  void x(float anX) {
    _x = anX;
  }

  float y() {
    return _y;
  }

  void y(float aY) {
    _y = aY;
  }
}

class ColorPoint {
  Point _point;
  color _color;

  public ColorPoint(Point aPoint, color aColor) {
    _point = aPoint;
    _color = aColor;
  }

  Point point() {
    return _point;
  }

  void point(Point aPoint) {
    _point = aPoint;
  }

  color hue() {
    return _color;
  }

  void hue(color aColor) {
    _color = aColor;
  }
}

class Crawler {
  ColorPoint _colorPoint;
  float _direction; // in radians

  public Crawler(ColorPoint aColorPoint, float aDirection) {
    _colorPoint = aColorPoint;
    _direction = aDirection;
  }

  ColorPoint colorPoint() {
    return _colorPoint;
  }

  void colorPoint(ColorPoint aColorPoint) {
    _colorPoint = aColorPoint;
  }

  float direction() {
    return _direction;
  }

  void direction(float aDirection) {
    _direction = aDirection;
  }
}

ArrayList<Crawler> crawlers;
color[] colors;

void setup() {
  size(800, 800);
  background(255);

  crawlers = new ArrayList<Crawler>();
  colors = new color[]{color(#DE2C32), color(#009FC1), color(#40908D), color(#E66028), color(#FCF396)};
}

void draw() {
  if (frameCount % 50 == 0) {
    Point aPoint = new Point(random(width/4, 3*width/4), random(height/4, 3*height/4));
    ColorPoint aColorPoint = new ColorPoint(aPoint, colors[(int)random(colors.length)]);

    crawlers.add(new Crawler(aColorPoint, random(TWO_PI)));
  }

  for (Crawler crawler : crawlers) {
    if (random(1) > .95) {
      crawler.direction(random(TWO_PI));
    }

    pushMatrix();

    ColorPoint theColorPoint = crawler.colorPoint();
    Point thePoint = theColorPoint.point();
    color theColor = theColorPoint.hue();
    translate(thePoint.x(), thePoint.y());
    rotate(crawler.direction());
    translate(1, 0);
    ellipseMode(CENTER);
    fill(theColor);
    noStroke();
    ellipse(0, 0, 2, 2);

    float newX = thePoint.x() + cos(crawler.direction());
    float newY = thePoint.y() + sin(crawler.direction());
    thePoint.x(newX);
    thePoint.y(newY);

    popMatrix();
  }
}
