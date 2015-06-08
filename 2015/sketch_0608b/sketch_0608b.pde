HDrawablePool rootPool;
HColorPool colors;

int sketchSize = 750;
int numColumns = 5;

HDrawablePool generateGridPool(HDrawable parent, int poolSize, int startX, int startY, int spacingX, int spacingY) {

	final int childPoolSize = poolSize;
	final int childStartX = startX;
	final int childStartY = startY;
	final int childSpacingX = spacingX/5;
	final int childSpacingY = spacingY/5;

	HDrawablePool pool = new HDrawablePool(poolSize);

	pool.autoParent(parent)
		.add( new HRect(spacingX, spacingY) )

		.layout(
			new HGridLayout(5)
				.startLoc(startX, startY)
				.spacing(spacingX, spacingY)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HRect d = (HRect) obj;
					d
						.anchorAt(H.TOP | H.LEFT)
						.stroke(colors.getColor())
						.noFill()
					;

					if (random(1) > .2 && childSpacingX > 5) {
						generateGridPool(d, childPoolSize, childStartX, childStartY, childSpacingX, childSpacingY);
					}

					/*d.add(new HText(str(d.x()) + ", " + str(d.y()))
						.fill(#FFFFFF)
						.loc(mouseX, mouseY)
					);*/
				}
			}
		)

		.requestAll()
	;

	return pool;
}

void setup(){
	size(sketchSize, sketchSize);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333);

	HCanvas rootCanvas = new HCanvas();
	H.add(rootCanvas);
	rootPool = generateGridPool(rootCanvas, 25, 0, 0, sketchSize/numColumns, sketchSize/numColumns);
}
 
void draw(){ 
	H.drawStage();
}

void keyPressed() {
	if (key == 'p') {
		saveFrame();
	}
}

