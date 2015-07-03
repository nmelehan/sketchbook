var sketchCollection = window.sketchCollection || {};

$(document).ready(function() {
    $('div#slideshow div.slide').each(function () {
        var sketchName = $(this).children("img").attr("alt");

        if (sketchCollection.hasOwnProperty(sketchName)) {
            console.log("attempting init for sketch with name: " + sketchName);
            sketchCollection[sketchName].init(this);
        }
        else {
            console.log("no sketch found with name: " + sketchName);
        }
    });
});

$(window).resize(function() {
    $('div#slideshow div.slide').each(function () {
        var sketchName = $(this).children("img").attr("alt");

        if (sketchCollection.hasOwnProperty(sketchName)) {
            console.log("attempting resize for sketch with name: " + sketchName);
            sketchCollection[sketchName].resize();
        }
        else {
            console.log("no sketch found with name: " + sketchName);
        }
    });
});