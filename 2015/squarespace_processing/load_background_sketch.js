var backgroundSketch = {};

backgroundSketch.setSketchSize = function() {
	var parentWidth = $("#homeBlockField").innerWidth();
	var parentHeight = $("#homeBlockField").innerHeight();
	backgroundSketch.processingInstance.size(parentWidth, parentHeight);
	$("#background_sketch").width(parentWidth);
	$("#background_sketch").height(parentHeight);
}

$(document).ready(function() {
	backgroundSketch.canvas = document.getElementById("background_sketch");
	// attaching the sketchProc function to the canvas
	backgroundSketch.processingInstance = new Processing(backgroundSketch.canvas, backgroundSketchCode);
	$("#background_sketch").appendTo("#homeBlockField");
	backgroundSketch.setSketchSize();
});

backgroundSketch.resize = function() {
	// save image data so it can be applied to context after resize
	var sketchCanvasContext = backgroundSketch.canvas.getContext("2d");
	var oldWidth = backgroundSketch.canvas.width;
	var oldHeight = backgroundSketch.canvas.height;
	var imageData = sketchCanvasContext.getImageData(0, 0, oldWidth, oldHeight);

	// resize
	backgroundSketch.setSketchSize();

	// apply saved image data
	var newWidth = backgroundSketch.canvas.width;
	var newHeight = backgroundSketch.canvas.height;

	var imageDataX = (newWidth - oldWidth)/2;
	var imageDataY = (newHeight - oldHeight)/2;
	sketchCanvasContext.putImageData(imageData, imageDataX, imageDataY);
}

$(window).resize(function() {
	backgroundSketch.resize();
});