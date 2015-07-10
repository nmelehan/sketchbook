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

	PVector pointCoordinatesForGridAndCellCoordinates(int gridColumn, int gridRow, int cellColumn, int cellRow) {
		float offsetX = gridColumn * (widthOfGridColumn() + _gridGap) + cellColumn * (_cellSize+_cellGap);
		float offsetY = gridRow * (heightOfGridRow() + _gridGap) + cellRow * (_cellSize+_cellGap);

		return new PVector(offsetX, offsetY);
	}

	// Rendering subroutines

	void renderCellGrid(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

		HRect cellRect = new HRect(_cellSize, _cellSize);
		cellRect
				.fill(255)
				.noStroke()
				.alpha(100);

		for (int currentGridColumn = 0; currentGridColumn < numberOfGridColumns(); currentGridColumn++) {
			for (int currentGridRow = 0; currentGridRow < numberOfGridRows(); currentGridRow++) {
				for (int currentCellColumn = 0; currentCellColumn < _numberOfCellsPerGridSide; currentCellColumn++) {
					for (int currentCellRow = 0; currentCellRow < _numberOfCellsPerGridSide; currentCellRow++) {
						float offsetX = currentGridColumn * (widthOfGridColumn() + _gridGap) + currentCellColumn * (_cellSize+_cellGap);
						float offsetY = currentGridRow * (heightOfGridRow() + _gridGap) + currentCellRow * (_cellSize+_cellGap);

						cellRect.loc(drawX + offsetX, drawY + offsetY);
						cellRect.paintAll(g, usesZ, currAlphaPc);
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

		int standardGradHeightInGridRows = 6;
		int minGradWidthInGridColumns = 5;
		int maxGradWidthInGridColumns = 8;

		PCHLinearGradient grad = new PCHLinearGradient(_startColor, _endColor)
			.axis(PCHLinearGradient.YAXIS);

		while (gradYInGridRows < numberOfGridRows()) {
			float inter = map(gradYInGridRows*heightOfGridRowAndGap(), 0, totalHeightOfGridSpan(), 0, 1);
			color gradLerp = H.app().lerpColor(_startColor, _endColor, inter);
			color gradLerpFaded = color(red(gradLerp), green(gradLerp), blue(gradLerp), random(25, 75));

			gradHeightInGridRows = min(standardGradHeightInGridRows, numberOfGridRows() - gradYInGridRows);

			while(gradXInGridColumns < numberOfGridColumns()) {
				color gradStartColor = color(255, random(25, 75));
				color gradEndColor = gradLerpFaded;

				// randomly point gradient up or down
				if (random(1) > .5) {
					gradStartColor = gradLerpFaded;
					gradEndColor = color(255, random(25, 75));
				}

				gradWidthInGridColumns = (numberOfGridColumns() - gradXInGridColumns) < maxGradWidthInGridColumns
						? numberOfGridColumns() - gradXInGridColumns
						: (int)random(minGradWidthInGridColumns, maxGradWidthInGridColumns);

				grad
					.startColor(gradStartColor)
					.endColor(gradEndColor)
					.loc(drawX + gradXInGridColumns*widthOfGridColumnAndGap(), drawY + gradYInGridRows*heightOfGridRowAndGap())
					.size(widthOfGridColumnAndGap()*gradWidthInGridColumns - _gridGap, heightOfGridRowAndGap()*gradHeightInGridRows - _gridGap)
					;

				grad.paintAll(g, usesZ, currAlphaPc);

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
		int minNumberOfMarksInSeries = 2;
		int maxNumberOfMarksInSeries = 10;

		int numberOfMarksInSeries = floor(random(minNumberOfMarksInSeries, maxNumberOfMarksInSeries));

		// Render left side
		PVector seriesOrigin = pointCoordinatesForGridAndCellCoordinates(
				(int)random(numberOfGridColumns()/2),
				(int)random(numberOfGridRows()),
				(int)random(_numberOfCellsPerGridSide),
				(int)random(_numberOfCellsPerGridSide)
				);

		// Render mirrored (right) side

		HGroup markerSeriesLeft = new HGroup();
		int seriesX = floor(random(10))*widthOfGridColumnAndGap();
		int seriesY = floor(random(20))*7*5;
		markerSeriesLeft.loc(seriesOrigin.x, seriesOrigin.y);

		int markerHeight = floor(random(15, 21));
		int markerWidth = 4-(markerHeight-19);

		HGroup markerSeriesRight = new HGroup();
		markerSeriesRight.anchorAt(H.BOTTOM | H.LEFT)
			.loc(_width-seriesOrigin.x, seriesOrigin.y+markerHeight)
			.rotate(180);

		float markerGap = 2;
		float markerAddonVerticalGap = floor(random(3)) * 5;
		float xPos = 0;
		for (int i = 0; i < numberOfMarksInSeries; i++) {
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

		println("blue cell grid currAlphaPC: " + currAlphaPc);
		// draw background color gradient
		PCHLinearGradient backgroundGrad = new PCHLinearGradient(_startColor, _endColor);
		backgroundGrad
			.axis(PCHLinearGradient.YAXIS)
			.size(_width, _height)
			;
		backgroundGrad.paintAll(g, usesZ, currAlphaPc);

		// draw cell grid
		float gridOffsetX = (_width-totalWidthOfGridSpan())/2;
		float gridOffsetY = (_height-totalHeightOfGridSpan())/2;
		renderCellGrid(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

		renderTopGradients(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

		renderAccentMarks(g, usesZ, drawX, drawY, currAlphaPc);

	} // end -- draw()

} // end -- class BlueCellGrid
