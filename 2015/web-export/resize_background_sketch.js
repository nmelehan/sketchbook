$("#content").resize(function() {
	backgroundSketch.processingInstance.size(window.innerWidth, window.innerHeight);
	$("#background_sketch").width(window.innerWidth);
	$("#background_sketch").height(window.innerHeight);
});