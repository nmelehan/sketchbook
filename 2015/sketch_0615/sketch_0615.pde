HDrawablePool pool;
HSwarm swarm;

HEllipse goal;

void addRing() {
  addRing(new PVector(0, 0));
}

void addRing(PVector origin) {
  final HSwarm swarm = new HSwarm().speed(5).turnEase(0.035f).twitch(4);

  final float originX = origin.x;
  final float originY = origin.y;

  // add goals in ring pattern
  final int ringResolution = 20;
  final int goalSize = 10;
  final int ringRadius = 40;
  final HDrawablePool ring = new HDrawablePool(ringResolution);
  ring
    .autoAddToStage()
    .add(new HEllipse(goalSize)
        .stroke(#FFFFFF)
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
}

void setup() {
  size(700, 700); 
 
  H.init(this).background(#161616);
  
  // HCanvas canvas = new HCanvas();
  // canvas.autoClear(false).fade(600);
  // H.add(canvas);
  
  // goal = new HEllipse(10);
  // goal.stroke(#FF3300).strokeWeight(3).noFill().loc(width/2, height/2);
  // H.add(goal);
  
  // swarm = new HSwarm().addGoal(goal).speed(5).turnEase(0.035f).twitch(4);
  
  // pool = new HDrawablePool(20)
  //   .autoParent(canvas)
  //   .add (new HRect(10, 4).rounding(2))
  //   .colorist(new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600))
  //   .onCreate(new HCallback() { 
  //       public void run(Object obj) {
  //         HDrawable d = (HDrawable)obj;
  //         d.loc(random(width), random(height))
  //           .noStroke();
  //         swarm.addTarget(d);
  //       }
  //     }
  //   );
    
    
  // HTimer trigger = new HTimer(500, 20)
  //   .callback(new HCallback() { 
  //       public void run(Object obj)  {
  //         pool.request();
  //       }
  //   }
  // );
  
  // HTimer goalTrigger = new HTimer(4000)
  //   .callback(new HCallback() { 
  //       public void run(Object obj)  {
  //         ///goal.loc(random(width), random(height));
  //         HEllipse newGoal = new HEllipse(10);
  //         newGoal.stroke(#FF3300).strokeWeight(3).noFill().loc(random(width), random(height));
  //         H.add(newGoal);
  //         swarm.addGoal(newGoal);
  //       }
  //   }
  // );

  addRing(new PVector(width/2, height/2));

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
