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

				PCHLinearGradient grad = new PCHLinearGradient(gradStartColor, gradEndColor);
				grad
					.setAxis(PCHLinearGradient.YAXIS)
					.loc(gradXInGridColumns*widthOfGridColumnAndGap(), gradYInGridRows*heightOfGridRowAndGap())
					.size(widthOfGridColumnAndGap()*gradWidthInGridColumns - _gridGap, heightOfGridRowAndGap()*gradHeightInGridRows - _gridGap)
					;

				grad.draw(g, usesZ, drawX + grad.x(), drawY + grad.y(), currAlphaPc);

				gradXInGridColumns += gradWidthInGridColumns;
			}

			gradXInGridColumns = 0;
			gradYInGridRows += gradHeightInGridRows;
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
			.setAxis(PCHLinearGradient.YAXIS)
			.size(_width, _height)
			;
		backgroundGrad.draw(g, usesZ, drawX, drawY, currAlphaPc);

		// draw cell grid
		float gridOffsetX = (_width-totalWidthOfGridSpan())/2;
		float gridOffsetY = (_height-totalHeightOfGridSpan())/2;
		renderCellGrid(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

		renderTopGradients(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

	} // end -- draw()

} // end -- class BlueCellGrid
