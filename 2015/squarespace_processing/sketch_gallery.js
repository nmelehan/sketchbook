var sketchCollection = window.sketchCollection || {};

$(document).ready(function() {
    $('div#slideshow div.slide').each(function () {
        var sketchName = $(this).children("img").attr("alt");
        var imgTag = $(this).children("img")[0];

        if (sketchCollection.hasOwnProperty(sketchName)) {
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