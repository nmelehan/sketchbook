HGroup goalGroup;
HGroup swarmGroup;
HGroup colorFieldGroup;
HColorField colorField;
HSwarm swarmBehavior;

void addSwarm() {
  // add swarm pool
  final int swarmSize = 10;

  HCanvas canvas = new HCanvas();
  canvas.autoClear(false).fade(1);
  swarmGroup = new HGroup();
  canvas.add(swarmGroup);
  H.add(canvas);


  swarmBehavior = new HSwarm().speed(4).turnEase(0.01f).twitch(2);

  final HDrawablePool swarmPool = new HDrawablePool(swarmSize);
  swarmPool
    .autoParent(swarmGroup)

    .add (new HEllipse()
			.size(4)
			.anchorAt(H.CENTER)
			.noStroke()
		    .fill(#C69300)
	    )

    .onCreate(new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable)obj;
          d.loc(random(width), random(height));
          swarmBehavior.addTarget(d);
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

void addGoal(PVector origin) {
  if (goalGroup == null) {
  	goalGroup = new HGroup();
  	H.add(goalGroup);
  }

  HEllipse ell = new HEllipse(10);
  ell
        .stroke(#000000, 20)
        .strokeWeight(2)
        .noFill()
        .anchorAt(H.CENTER)
        .loc(origin.x, origin.y);

  goalGroup.add(ell);
  swarmBehavior.addGoal(ell);
}

void addColorField() {
	colorField = new HColorField(width, height)
		.addPoint(0, height/2, #FF0066, 0.8f)
		.addPoint(width, height/2, #3300FF, 0.7f)
		.fillOnly()
	;

	colorFieldGroup = new HGroup();
  H.add(colorFieldGroup);
  HDrawablePool pool = new HDrawablePool(100);
	pool
    .autoParent(colorFieldGroup)
		.add (
			new HRect(40,70)
		)

		.layout (
			new HGridLayout()
			.startX(0)
			.startY(0)
			.spacing(40,70)
			.cols(10)
		)

		.onCreate (
			new HCallback(){
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					colorField.applyColor(d);
					d.noStroke();
				}
			}
		)

		.requestAll()
	;
}

void setup() {
  size(400, 700);

  H.init(this).background(#dddddd);

  addColorField();

  addSwarm();
  for (int i = 0; i < 10; i++) {
  	addGoal(new PVector(random(width), random(height)));
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
  updateColorField();
}

void updateColorField() {
  for (HDrawable d : swarmGroup) {
    println(d.loc());
  }
  println();
}

void keyPressed() {
  if (key == 'p') {
    saveFrame();
  }
}