var sketchCollection = window.sketchCollection || {};

$(document).ready(function() {
    $('div#slideshow div.slide').each(function () {
        // Each sketch is named in correspondence
        // with the gallery image's title, which Squarespace
        // assigns as the alt attribute of the image element
        var sketchName = $(this).children("img").attr("alt");
        var imgTag = $(this).children("img")[0];

        // Test to see if there is a corresponding
        // processing sketch for the gallery image
        if (sketchCollection.hasOwnProperty(sketchName)) {
            $(imgTag).css("visibility", "hidden");

            // When the gallery image finishes loading,
            // initialize the corresponding sketch.
            // We wait till the gallery image loads so that
            // the sketch's canvas can be properly sized.
            //
            // The one().filter().load() pattern helps us
            // safely initialize both when the image has
            // already loaded by now, and when it is yet to load.
            $(imgTag).one('load',function(){
                    sketchCollection[sketchName].init(this.parentElement);
                })
                .filter(function(){
                     return this.initComplete;
                })
                .load();
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