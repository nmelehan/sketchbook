PCHLinearGradient backgroundGrad;

color startColor = #54C9F4;
color endColor = #A6E2FC;

int sketchWidth = 2000, sketchHeight = 2000;

int cellSize = 20;
int numCols = sketchWidth/cellSize;
int numRows = sketchHeight/cellSize;

int gradHeight = 7;

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
	int seriesX = floor(random(numCols/2))*cellSize;
	int seriesY = floor(random(numRows*4))*5;
	markerSeriesLeft.loc(seriesX, seriesY);

	int markerHeight = floor(random(15, 21));
	int markerWidth = 4-(markerHeight-19);

	HGroup markerSeriesRight = new HGroup();
	markerSeriesRight.anchorAt(H.BOTTOM | H.LEFT)
		.loc(sketchWidth-seriesX, seriesY+markerHeight)
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
	size(sketchWidth, sketchHeight);
	H.init(this).background(#FFFFFF);

	backgroundGrad = new PCHLinearGradient(startColor, endColor);
	H.add(backgroundGrad);
	backgroundGrad
		.setAxis(PCHLinearGradient.YAXIS)
		.size(sketchWidth, sketchHeight)
		;

	HDrawablePool cellPool = new HDrawablePool(numRows*numCols)
		.autoParent(backgroundGrad)
		.add(new HGroup())
		.layout(
			new HGridLayout()
				.startX(1)
				.startY(1)
				.spacingX(cellSize)
				.spacingY(cellSize)
				.cols(numCols)
		)
		.onCreate(new HCallback() {
			public void run(Object obj) {
				HGroup d = (HGroup)obj;
				cell(d);
			}
		})
		.requestAll();

	int numGradientRows = ceil(sketchHeight/(float)(gradHeight*cellSize));
	for (int i = 0 ; i < numGradientRows ; i++) {
		int j = 0;
		float inter = map(i*cellSize, 0, sketchHeight, 0, 1);
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
				.loc(j*cellSize, i*gradHeight*cellSize)
				;
			backgroundGrad.add(grad);

			if (numCols-j <= 6) {
				grad.size(cellSize*(numCols-j), gradHeight*cellSize);
				break;
			}
			else {
				int gradWidth = (int)random(3,6);
				grad.size(cellSize*gradWidth, gradHeight*cellSize);
				j+=gradWidth;
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
