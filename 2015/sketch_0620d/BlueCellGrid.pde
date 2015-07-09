public static class BlueCellGrid extends HDrawable {

	private int _cellSize = 3;
	private int _cellGap = 1;
	private int _gridGap = 2;
	private int _numberOfCellsPerGridSide = 5;

	// Class methods
	//
	//

	int widthOfGridColumn() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap;
	}

	int heightOfGridRow() {
		return (_cellSize+_cellGap)*_numberOfCellsPerGridSide - _cellGap;
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

		HRect cellRect = new HRect(_cellSize);
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


	// Subclass methods
	//
	//

	public BlueCellGrid createCopy() {
		BlueCellGrid copy = new BlueCellGrid();
		copy.copyPropertiesFrom(this);
		return copy;
	}

	public void draw(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

		color startColor = #54C9F4;
		color endColor = #A6E2FC;

		// draw background color gradient
		PCHLinearGradient backgroundGrad = new PCHLinearGradient(startColor, endColor);
		backgroundGrad
			.setAxis(PCHLinearGradient.YAXIS)
			.size(_width, _height)
			;
		backgroundGrad.draw(g, usesZ, drawX, drawY, currAlphaPc);

		// draw cell grid
		float gridOffsetX = (_width-totalWidthOfGridSpan())/2;
		float gridOffsetY = (_height-totalHeightOfGridSpan())/2;
		renderCellGrid(g, usesZ, drawX+(int)gridOffsetX, drawY+(int)gridOffsetY, currAlphaPc);

	} // end -- draw()

} // end -- class BlueCellGrid
