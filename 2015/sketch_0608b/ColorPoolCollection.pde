class ColorPoolCollection {
	ArrayList<HColorPool> colorPoolCollection;

	public int currentColorPoolIndex;

	public ColorPoolCollection() {
		colorPoolCollection = new ArrayList<HColorPool>();
		currentColorPoolIndex = 0;

		HColorPool colors;

		// DSPIP Blue
		colors = new HColorPool()
				.add(#3399CC)
				.add(#67B8DE)
				.add(#91C9E8)
				.add(#B4DCED)
				.add(#E8F8FF);
		colorPoolCollection.add(colors);

		// Colors of Rio
		colors = new HColorPool()
				.add(#E83A25)
				.add(#FFE9A3)
				.add(#98CC96)
				.add(#004563)
				.add(#191B28);
		colorPoolCollection.add(colors);

		// Sunshine over glacier
		colors = new HColorPool()
				.add(#004056)
				.add(#2C858D)
				.add(#74CEB7)
				.add(#C9FFD5)
				.add(#FFFFCB);
		colorPoolCollection.add(colors);

		// Organic pull 2
		colors = new HColorPool()
				.add(#776045)
				.add(#A8C545)
				.add(#DFD3B6)
				.add(#FFFFFF)
				.add(#0092B2);
		colorPoolCollection.add(colors);

		// Settles accent
		colors = new HColorPool()
				.add(#EA6045)
				.add(#F8CA4D)
				.add(#F5E5C0)
				.add(#3F5666)
				.add(#2F3440);
		colorPoolCollection.add(colors);

		// Campfire
		colors = new HColorPool()
				.add(#588C7E)
				.add(#F2E394)
				.add(#F2AE72)
				.add(#D96459)
				.add(#8C4646);
		colorPoolCollection.add(colors);
	}

	HColorPool getCurrentPool() {
		return colorPoolCollection.get(currentColorPoolIndex);
	}

	color getColor() {
		return colorPoolCollection.get(currentColorPoolIndex).getColor();
	}

	void advancePool() {
		currentColorPoolIndex = (currentColorPoolIndex+1)%colorPoolCollection.size();
	}
}