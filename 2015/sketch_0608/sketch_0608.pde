HDrawablePool rootPool;
HColorPool colors;

HText mouseCoords;

HDrawablePool generateHexPool(HDrawable parent, int poolSize, int spacing, int hexShapeSize) {

	final int thisHexShapeSize = hexShapeSize;

	final int childPoolSize = poolSize;
	final int childSpacing = spacing/5;
	final int childHexShapeSize = hexShapeSize / 5;

		println(parent.x());

	HDrawablePool pool = new HDrawablePool(poolSize);

	if (hexShapeSize  > 100) {

	pool.autoParent(parent)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(spacing)
			.offsetX(parent.x())
			.offsetY(parent.y())
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(thisHexShapeSize)
						.anchorAt(H.CENTER)
						.stroke(colors.getColor())
						.noFill()
					;

					if (random(1) > 0 && childHexShapeSize > 5) {
						generateHexPool(d, childPoolSize, childSpacing, childHexShapeSize);
					}

					d.add(new HText(str(d.x()) + ", " + str(d.y()))
						.fill(#FFFFFF)
						.loc(mouseX, mouseY)
					);
				}
			}
		)

		.requestAll()
	;


	/*for (HDrawable d : pool) {

	}*/
}
else {
	parent.add (new HRect(20).fill(#FF4400));
}

	return pool;
}

void setup(){
	size(640,640);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333);

	HRect rootCanvas = new HRect(width, height);
	rootCanvas.loc(width/2, height/2);
	H.add(rootCanvas);
	rootPool = generateHexPool(rootCanvas, 19, 100, 200);

	mouseCoords = new HText();
	H.add(mouseCoords);
}
 
void draw(){ 
	H.drawStage();
	mouseCoords
		.text(str(mouseX) + ", " + str(mouseY))
		.fill(#FFFFFF)
		.loc(mouseX, mouseY);
}

