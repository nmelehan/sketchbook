public class BlueCellGrid extends HDrawable {

	private int _cellSize = 3;
	private int _cellGap = 1;
	private int _gridGap = 2;
	private int _numberOfCellsPerGridSide = 5;

	color _startColor = #54C9F4;
	color _endColor = #A6E2FC;

	// Class methods
	//
	//

	int widthOfGridColumn() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap;
	}

	int widthOfGridColumnAndGap() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap + _gridGap;
	}

	int heightOfGridRow() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap;
	}

	int heightOfGridRowAndGap() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap + _gridGap;
	}

	int numberOfGridColumns() {
		return (int)Math.floor((_width+_gridGap)/(widthOfGridColumn()+_gridGap));
	}

	int numberOfGridRows() {
		return (int)Math.floor((_height+_gridGap)/(heightOfGridRow()+_gridGap));
	}

	int totalWidthOfGridSpan() {
		return (widthOfGridColumn()+_gridGap)*numberOfGridColumns() - _gridGap;
	}

	int totalHeightOfGridSpan() {
		return (heightOfGridRow()+_gridGap)*numberOfGridRows() - _gridGap;
	}

	// Rendering subroutines

	void renderCellGrid(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

		HRect cellRect = new HRect(_cellSize, _cellSize);
		cellRect
				.fill(255)
				.noStroke()
				.alpha(70);

		for (int currentGridColumn = 0; currentGridColumn < numberOfGridColumns(); currentGridColumn++) {
			for (int currentGridRow = 0; currentGridRow < numberOfGridRows(); currentGridRow++) {
				for (int currentCellColumn = 0; currentCellColumn < _numberOfCellsPerGridSide; currentCellColumn++) {
					for (int currentCellRow = 0; currentCellRow < _numberOfCellsPerGridSide; currentCellRow++) {
						float offsetX = currentGridColumn * (widthOfGridColumn() + _gridGap) + currentCellColumn * (_cellSize+_cellGap);
						float offsetY = currentGridRow * (heightOfGridRow() + _gridGap) + currentCellRow * (_cellSize+_cellGap);

						cellRect.loc(offsetX, offsetY);
						cellRect.draw(g, usesZ, drawX + cellRect.x(), drawY + cellRect.y(), currAlphaPc);
					}
				}
			}
		}

	} // end -- renderCellGrid()

	void renderTopGradients(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		int gradXInGridColumns = 0;
		int gradYInGridRows = 0;
		int gradWidthInGridColumns = 0;
		int gradHeightInGridRows = 0;

		PCHLinearGradient grad = new PCHLinearGradient(_startColor, _endColor)
			.axis(PCHLinearGradient.YAXIS);

		while (gradYInGridRows < numberOfGridRows()) {
			float inter = map(gradYInGridRows*heightOfGridRowAndGap(), 0, totalHeightOfGridSpan(), 0, 1);
			color gradLerp = H.app().lerpColor(_startColor, _endColor, inter);
			color gradLerpFaded = color(red(gradLerp), green(gradLerp), blue(gradLerp), 25);

			gradHeightInGridRows = min(6, numberOfGridRows() - gradYInGridRows);

			while(gradXInGridColumns < numberOfGridColumns()) {
				color gradStartColor = color(255, 25);
				color gradEndColor = gradLerpFaded;

				// randomly point gradient up or down
				if (random(1) > .5) {
					gradStartColor = gradLerpFaded;
					gradEndColor = color(255, 25);
				}

				gradWidthInGridColumns = (numberOfGridColumns() - gradXInGridColumns) < 6 ? numberOfGridColumns() - gradXInGridColumns : (int)random(3, 6);

				grad
					.startColor(gradStartColor)
					.endColor(gradEndColor)
					.loc(gradXInGridColumns*widthOfGridColumnAndGap(), gradYInGridRows*heightOfGridRowAndGap())
					.size(widthOfGridColumnAndGap()*gradWidthInGridColumns - _gridGap, heightOfGridRowAndGap()*gradHeightInGridRows - _gridGap)
					;

				grad.draw(g, usesZ, drawX + grad.x(), drawY + grad.y(), currAlphaPc);

				gradXInGridColumns += gradWidthInGridColumns;
			}

			gradXInGridColumns = 0;
			gradYInGridRows += gradHeightInGridRows;
		}
	} // end -- renderTopGradients()

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

	public void renderAccentMarkSeries(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		int numMarks = floor(random(2, 10));

		HGroup markerSeriesLeft = new HGroup();
		int seriesX = floor(random(10))*widthOfGridColumnAndGap();
		int seriesY = floor(random(20))*7*5;
		markerSeriesLeft.loc(seriesX, seriesY);

		int markerHeight = floor(random(15, 21));
		int markerWidth = 4-(markerHeight-19);

		HGroup markerSeriesRight = new HGroup();
		markerSeriesRight.anchorAt(H.BOTTOM | H.LEFT)
			.loc(_width-seriesX, seriesY+markerHeight)
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

		markerSeries.paintAll(g, usesZ, currAlphaPc);
	}

	public void renderAccentMarks(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {
		 for (int i = 0; i < 10+random(10); i++) {
			renderAccentMarkSeries(g, usesZ, drawX, drawY, currAlphaPc);
		}
	}

	// Subclass methods
	//
	//

	public BlueCellGrid createCopy() {
		BlueCellGrid copy = new BlueCellGrid();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

		// draw background color gradient
		PCHLinearGradient backgroundGrad = new PCHLinearGradient(_startColor, _endColor);
		backgroundGrad
			.axis(PCHLinearGradient.YAXIS)
			.size(_width, _height)
			;
		backgroundGrad.draw(g, usesZ, drawX, drawY, currAlphaPc);

		// draw cell grid
		float gridOffsetX = (_width-totalWidthOfGridSpan())/2;
		float gridOffsetY = (_height-totalHeightOfGridSpan())/2;
		renderCellGrid(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

		renderTopGradients(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

		renderAccentMarks(g, usesZ, drawX, drawY, currAlphaPc);

	} // end -- draw()

} // end -- class BlueCellGrid
