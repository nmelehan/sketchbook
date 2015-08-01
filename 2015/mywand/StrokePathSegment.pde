public class StrokePathSegment {
	public Stroke _stroke1;
	public Stroke _stroke2;

	public boolean _pathBeginning = false;
	public boolean _pathEnding = false;

	public StrokePathSegment(Stroke stroke1, Stroke stroke2) {
		_stroke1 = stroke1;
		_stroke2 = stroke2;
	}
}