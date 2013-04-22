Modernizr.addTest('video', function(){
  var elem = document.createElement('video'),
  bool = false;

  try {
    if ( bool = !!elem.canPlayType ) {
      bool      = new Boolean(bool);
      bool.ogg  = elem.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,'');
      bool.h264 = elem.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,'');
      bool.webm = elem.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,'');
    }

  } catch(e) { }

  return bool;
});

