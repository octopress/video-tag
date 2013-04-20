var swfVideoSwap = function (path) {
  if (typeof(path) == 'undefined') {
    path = "/assets/video/";
  }

  var player = path+"player.swf",
      skin = path+"glow/glow.xml";

  videos = $('video');
  if videos.length {
    var swfobject = require('video/swfobject')
    if (!Modernizr.video.h264 && !Modernizr.video.webm && !Modernizr.video.ogv && swfobject.getFlashPlayerVersion() || window.location.hash.indexOf("flash-test") !== -1){
      videos.each(function(i, video){
        swap($(video), player, skin);
      });
    }
  }
}

var swap = function (video, player, skin){
  video.children('source[src$=mp4]').first().map(function(i, source){
    var src = $(source).attr('src'),
        id = 'video_'+Math.round(1 + Math.random()*(100000)),
        width = video.attr('width'),
        height = parseInt(video.attr('height'), 10) + 30;
        video.after('<div class="flash-video"><div><div id='+id+'>');
    swfobject.embedSWF(player, id, width, height + 30, "9.0.0",
      { file : src, image : video.attr('poster'), skin : skin } ,
      { movie : src, wmode : "opaque", allowfullscreen : "true" }
    );
  });
  video.remove();
};

module.exports = swfVideoSwap;
