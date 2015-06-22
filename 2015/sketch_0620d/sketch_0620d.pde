void cell(HDrawable d) {
	HDrawablePool pool = new HDrawablePool(25)
		.autoParent(d)
		.add(new HRect(3, 3)
			.fill(#ffffff)
			.noStroke()
			.alpha(100))
		.layout(
			new HGridLayout()
				.startX(1)
				.startY(1)
				.spacingX(3.75)
				.spacingY(3.75)
				.cols(5)
		)
		.requestAll();
}

PCHLinearGradient backgroundGrad;

//color startColor = #0783BE;
color startColor = #54C9F4;
color endColor = #A6E2FC;

HGroup addons(HGroup markerSeries) {
	float addonProbabilityThreshold = .8;

	for (HDrawable s : markerSeries) {
		HGroup series = (HGroup)s;
		HGroup addons = new HGroup();
		for (HDrawable m : series) {
			HRect marker = (HRect)m;
			boolean addonIsAbove = (random(1) > .5) ? true : false;
			if (random(1)>addonProbabilityThreshold) {
				HRect extension = marker.createCopy();
				float newHeight = marker.height()*random(.1,.9);
				extension.height(newHeight);
				if (addonIsAbove) {
					extension.y(-1*newHeight);
				}
				else {
					extension.y(marker.height());
				}
				addons.add(extension);
			}
		}
		series.add(addons);
	}

	return markerSeries;
}


HGroup darkMarkSeries() {
	int numMarks = floor(random(2, 10));

	HGroup markerSeriesLeft = new HGroup();
	int seriesX = floor(random(10))*20;
	int seriesY = floor(random(20))*7*5;
	markerSeriesLeft.loc(seriesX, seriesY);

	int markerHeight = floor(random(15, 21));
	int markerWidth = 4-(markerHeight-19);

	HGroup markerSeriesRight = new HGroup();
	markerSeriesRight.anchorAt(H.BOTTOM | H.LEFT)
		.loc(400-seriesX, seriesY+markerHeight)
		.rotate(180);

	float markerGap = 2;
	float markerAddonVerticalGap = floor(random(3)) * 5;
	float xPos = 0;
	for (int i = 0; i < numMarks; i++) {
		xPos+=(markerWidth+markerGap);
		HRect markerRect = new HRect(markerWidth, markerHeight);
		markerRect
			.loc(xPos, 0)
			.fill(#4293D4)
			.noStroke();
		markerSeriesLeft.add(markerRect);
		markerSeriesRight.add(markerRect.createCopy());
	}

	HGroup markerSeries = new HGroup();
	markerSeries.add(markerSeriesLeft);
	markerSeries.add(markerSeriesRight);

	addons(markerSeries);

	return markerSeries;
}

HGroup markerGroup;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	backgroundGrad = new PCHLinearGradient(startColor, endColor);
	H.add(backgroundGrad);
	backgroundGrad
		.setAxis(PCHLinearGradient.YAXIS)
		.size(400, 700)
		.loc(200, 50)
		;

	HDrawablePool cellPool = new HDrawablePool(700)
		.autoParent(backgroundGrad)
		.add(new HGroup())
		.layout(
			new HGridLayout()
				.startX(1)
				.startY(1)
				.spacingX(20)
				.spacingY(20)
				.cols(20)
		)
		.onCreate(new HCallback() {
			public void run(Object obj) {
				HGroup d = (HGroup)obj;
				cell(d);
			}
		})
		.requestAll();

	for (int i = 0 ; i < 5 ; i++) {
		int gradHeight = 7;
		int j = 0;
		float inter = map(i*20, 0, 700, 0, 1);
		color gradLerp = lerpColor(startColor, endColor, inter);
		color gradLerpFaded = color(red(gradLerp), green(gradLerp), blue(gradLerp), 25);
		while(true) {
			color gradStartColor = color(255, 25), gradEndColor = gradLerpFaded;
			if (random(1) > .5) {
				gradStartColor = gradLerpFaded;
				gradEndColor = color(255, 25);
			}

			PCHLinearGradient grad = new PCHLinearGradient(gradStartColor, gradEndColor);
			grad
				.setAxis(PCHLinearGradient.YAXIS)
				.loc(j*20, i*gradHeight*20)
				;
			backgroundGrad.add(grad);

			if (20-j <= 6) {
				grad.size(20*(20-j), gradHeight*20);
				break;
			}
			else {
				int gradWidth = (int)random(3,6);
				grad.size(20*gradWidth, gradHeight*20);
				j+=gradWidth;


				// if (gradWidth >= 5) {
				// PCHLinearGradient subGrad = new PCHLinearGradient(gradStartColor, gradEndColor);
				// grad.add(subGrad);
				// int anchor = floor(random(4));
				// grad.setAxis(PCHLinearGradient.YAXIS)
				// 	.size(random(3, 4)
				// }
			}
		}
	}

	markerGroup = new HGroup();
	backgroundGrad.add(markerGroup);

	for (int i = 0; i < 10+random(10); i++) {
		markerGroup.add(darkMarkSeries());
	}
}

void draw() {
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
	if (key == 'c') {
		for (HDrawable child : markerGroup) {
			markerGroup.remove(child);
		}
	}
	if (key == 'g') {
		markerGroup.add(darkMarkSeries());
	}
	if (key == 's') {
		for (int i = 0; i < 10+random(10); i++) {
			markerGroup.add(darkMarkSeries());
		}
	}
}
