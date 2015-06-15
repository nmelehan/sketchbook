HDrawablePool pool;
HSwarm swarm;

HEllipse goal;

void addRing() {
  addRing(new PVector(0, 0), color(255));
}

void addRing(PVector origin, color swarmColor) {
  final HSwarm swarm = new HSwarm().speed(1).turnEase(0.05f).twitch(1);

  final float originX = origin.x;
  final float originY = origin.y;

  // add goals in ring pattern
  final int ringResolution = 20;
  final int goalSize = 5;
  final int ringRadius = 80;
  final HDrawablePool ring = new HDrawablePool(ringResolution);
  ring
    .autoAddToStage()
    .add(new HEllipse(goalSize)
        .stroke(#FFFFFF, 20)
        .strokeWeight(2)
        .noFill()
        .anchorAt(H.CENTER)
      )
    .onCreate(new HCallback() {
          public void run(Object obj) {
            HEllipse ell = (HEllipse)obj;
            int i = ring.currentIndex();
            float angle = i*TWO_PI/ringResolution;
            ell.loc(originX + ringRadius*cos(angle), originY + ringRadius*sin(angle));

            swarm.addGoal(ell);
          }
      })
    .requestAll();
    ;
  
  // add swarm pool
  final int swarmSize = 100;

  HCanvas canvas = new HCanvas();
  canvas.autoClear(false).fade(600);
  H.add(canvas);
  
  final HDrawablePool swarmPool = new HDrawablePool(swarmSize);
  swarmPool
    .autoParent(canvas)

    .add (new HRect(10, 4)
      .rounding(2)
      .noStroke()
      .fill(swarmColor)
      .anchorAt(H.CENTER)
    )

    .onCreate(new HCallback() { 
        public void run(Object obj) {
          HDrawable d = (HDrawable)obj;
          d.loc(random(width), random(height));
          swarm.addTarget(d);
        }
      }
    );
    
  HTimer trigger = new HTimer(500, swarmSize)
    .callback(new HCallback() { 
        public void run(Object obj)  {
          swarmPool.request();
        }
    }
  );
}

void setup() {
  size(700, 700); 
 
  H.init(this).background(#161616);

  HColorPool colors = new HColorPool(#F7F7F7, #0095A8, #00616F, #FF3300, #FF6600);

  PVector origin = new PVector(width/2, height/2);
  for (int i = -2; i <= 2; i++) {
    PVector ringOrigin = PVector.add(origin, new PVector(i*100, 0));
    addRing(ringOrigin, colors.getColor());
  }

  HPath xAxis = new HPath()
    .vertex(0, height/2)
    .vertex(width, height/2);
  HPath yAxis = new HPath()
    .vertex(width/2, 0)
    .vertex(width/2, height);
  H.add(xAxis);
  H.add(yAxis);
}

void draw() {
  H.drawStage();
}

void keyPressed() {
  if (key == 'p') {
    saveFrame();
  }
}
