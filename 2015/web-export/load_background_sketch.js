var backgroundSketch = {};

backgroundSketch.setSketchSize = function() {
	var parentWidth = $("#homeBlockField").innerWidth();
	var parentHeight = $("#homeBlockField").innerHeight();
	backgroundSketch.processingInstance.size(parentWidth, parentHeight);
	$("#background_sketch").width(parentWidth);
	$("#background_sketch").height(parentHeight);
}

$(document).ready(function() {
	var canvas = document.getElementById("background_sketch");
	// attaching the sketchProc function to the canvas
	backgroundSketch.processingInstance = new Processing(canvas, backgroundSketchCode);
	$("#background_sketch").appendTo("#homeBlockField");
	backgroundSketch.setSketchSize();
});

$(window).resize(function() {
	backgroundSketch.setSketchSize();
});