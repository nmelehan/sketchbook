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

  swarmBehavior = new HSwarm().speed(.5).turnEase(0.01f).twitch(2);

  final HDrawablePool swarmPool = new HDrawablePool(swarmSize);
  swarmPool
    .autoParent(swarmGroup)

    .add (new HEllipse()
  			.size(4)
  			.anchorAt(H.CENTER)
  			.noStroke()
		    .fill(#ffffff)
        .alpha(0)
	    )

    .onCreate(new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable)obj;
          d.loc(random(width), random(height));
          swarmBehavior.addTarget(d);
        }
      }
    )
    .requestAll()
    ;
}

void addGoal(PVector origin) {
  if (goalGroup == null) {
  	goalGroup = new HGroup();
  	H.add(goalGroup);
  }

  final HEllipse ell = new HEllipse(10);
  ell
        .stroke(#ffffff)
        .strokeWeight(5)
        .noFill()
        .anchorAt(H.CENTER)
        .loc(origin.x, origin.y)
        .alpha(0)
        ;

  goalGroup.add(ell);
  swarmBehavior.addGoal(ell);

  HTimer trigger = new HTimer(10000)
    .callback(new HCallback() {
        public void run(Object obj)  {
          ell.loc(random(width), random(height));
        }
    }
  );
}

void addColorField() {
  colorField = new HColorField(width, height)
    .addPoint(0, 0, #FF0066, 0.8f)
    .addPoint(width, height/2, #3300FF, 0.8f)
    .addPoint(0, height, #FF0066, .5)
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
          d

            .fill(#000000)
          ;
          colorField.applyColor(d);
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
}

void draw() {
  H.drawStage();
  updateColorField();
}

void updateColorField() {
  colorField.removeAllPoints();
  for (HDrawable d : swarmGroup) {
    colorField.addPoint(d.loc(), color(255, 0, 125, .1), 0.2f);
  }
  for (HDrawable d : colorFieldGroup) {
    d.fill(#000000);
    colorField.applyColor(d);
  }
}

void keyPressed() {
  if (key == 'p') {
    saveFrame();
  }
}