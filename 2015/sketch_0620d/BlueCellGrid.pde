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

	// PVector pointOffsetForGridCoordinates(int gridRow, int gridColumn, int cellRow, int cellColumn) {
	// 	float offsetX = gridColumn * (widthOfGridColumn() + _gridGap) + cellColumn * (_cellSize+_cellGap);
	// 	float offsetY = gridRow * (heightOfGridRow() + _gridGap) + cellRow * (_cellSize+_cellGap);

	// 	return new PVector(offsetX, offsetY);
	// }

	// void locateCell(HRect cellRect, PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

	// 	int currentGridRow = cellRect.numI("currentGridRow");
	// 	int currentGridColumn = cellRect.numI("currentGridColumn");
	// 	int currentCellRow = cellRect.numI("currentCellRow");
	// 	int currentCellColumn = cellRect.numI("currentCellColumn");

	// 	// println("locate, currentGridRow: " + currentGridRow + ", currentGridColumn: " + currentGridColumn);
	// 	// println("locate, currentCellRow: " + currentCellRow + ", currentCellColumn: " + currentCellColumn);

	// 	// PVector offset = pointOffsetForGridCoordinates(currentGridRow, currentGridColumn, currentCellRow, currentCellColumn);
	// 	float offsetX = currentGridColumn * (widthOfGridColumn() + _gridGap) + currentCellColumn * (_cellSize+_cellGap);
	// 	float offsetY = currentGridRow * (heightOfGridRow() + _gridGap) + currentCellRow * (_cellSize+_cellGap);
	// 	cellRect.loc(offsetX, offsetY);

	// 	// cellRect.loc(offset.x, offset.y);
	// 	cellRect.draw(g, usesZ, drawX + cellRect.x(), drawY + cellRect.y(), currAlphaPc);

	// 	currentCellColumn = currentCellColumn < _numberOfCellsPerGridSide-1 ? currentCellColumn + 1 : 0;
	// 	currentCellRow = currentCellColumn == 0 ? currentCellRow + 1 : currentCellRow;

	// 	if (currentCellRow < _numberOfCellsPerGridSide) {
	// 		cellRect.num("currentCellRow", currentCellRow);
	// 		cellRect.num("currentCellColumn", currentCellColumn);

	// 		locateCell(cellRect, g, usesZ, drawX, drawY, currAlphaPc);
	// 	}
	// 	else if (currentCellRow >= _numberOfCellsPerGridSide) {
	// 		// start a new grid
	// 		currentCellRow = 0;
	// 		currentCellColumn = 0;

	// 		currentGridColumn = currentGridColumn < 10/*numberOfGridColumns()-1*/ ? currentGridColumn + 1 : 0;
	// 		currentGridRow = currentGridColumn == 0 ? currentGridRow + 1 : currentGridRow;

	// 		if (currentGridRow < 13 /*numberOfGridRows()*/) {
	// 			cellRect.num("currentCellRow", currentCellRow);
	// 			cellRect.num("currentCellColumn", currentCellColumn);
	// 			cellRect.num("currentGridRow", currentGridRow);
	// 			cellRect.num("currentGridColumn", currentGridColumn);

	// 			locateCell(cellRect, g, usesZ, drawX, drawY, currAlphaPc);
	// 		}
	// 	}

	// } // end -- locateCell()

	// void renderCellGrid(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

	// 	HRect cellRect = new HRect(3, 3);
	// 	cellRect
	// 			.fill(0)
	// 			.noStroke()
	// 			.alpha(100);
	// 	cellRect.num("currentGridRow", 0);
	// 	cellRect.num("currentGridColumn", 0);
	// 	cellRect.num("currentCellRow", 0);
	// 	cellRect.num("currentCellColumn", 0);

	// 	locateCell(cellRect, g, usesZ, drawX, drawY, currAlphaPc);

	// 	println("finished rendering grid");
	// 	println(_width);
	// 	println(widthOfGridColumn());
	// 	println(numberOfGridColumns());

	// 	println(numberOfGridRows());

	// } // end -- renderCellGrid()

	void renderCellGrid(PGraphics g, boolean usesZ, float drawX, float drawY, float currAlphaPc) {

		HRect cellRect = new HRect(_cellSize);
		cellRect
				.fill(0)
				.noStroke()
				.alpha(100);

		for (int currentGridColumn = 0; currentGridColumn < numberOfGridColumns(); currentGridColumn++) {
			for (int currentGridRow = 0; currentGridRow < numberOfGridRows(); currentGridRow++) {
				for (int currentCellColumn = 0; currentCellColumn < _numberOfCellsPerGridSide; currentCellColumn++) {
					for (int currentCellRow = 0; currentCellRow < _numberOfCellsPerGridSide; currentCellRow++) {
						float offsetX = currentGridColumn * (widthOfGridColumn() + _gridGap) + currentCellColumn * (_cellSize+_cellGap);
						float offsetY = currentGridRow * (heightOfGridRow() + _gridGap) + currentCellRow * (_cellSize+_cellGap);
						cellRect.loc(offsetX, offsetY);

						// cellRect.loc(offset.x, offset.y);
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
		renderCellGrid(g, usesZ, drawX, drawY, currAlphaPc);

	} // end -- draw()

} // end -- class BlueCellGrid
