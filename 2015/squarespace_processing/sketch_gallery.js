var sketchCollection = window.sketchCollection || {};

$(document).ready(function() {
    $('div#slideshow div.slide').each(function () {
        var sketchName = $(this).children("img").attr("alt");

        if (sketchCollection.hasOwnProperty(sketchName)) {
            sketchCollection[sketchName].init(this);
        }
        else {
            console.log("[sketch_gallery.js] No sketch found with name: " + sketchName);
        }
    });
});

$(window).resize(function() {
    $('div#slideshow div.slide').each(function () {
        var sketchName = $(this).children("img").attr("alt");

        if (sketchCollection.hasOwnProperty(sketchName)) {
            sketchCollection[sketchName].resize();
        }
        else {
            console.log("[sketch_gallery.js] No sketch found with name: " + sketchName);
        }
    });
});