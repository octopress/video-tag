swfSwap = (path = "/assets/jwplayer/") ->
  player = path+"player.swf"
  skin = path+"glow/glow.xml"
  videos = $('video')

  if videos.length
    videos.each (i, video)->
      video = $(video)
      mp4   = video.find("source[type*='mp4']")[0]
      webm  = video.find("source[type*='webm']")[0]
      ogv   = video.find("source[type*='ogg']")[0]

      throw "Flash player requires mp4 video format" unless mp4?

      supported = Modernizr.video and (Modernizr.video.h264 or (Modernizr.video.webm and webm?) or (Modernizr.video.ogv and ogv?))
      supported = false if window.location.hash.match(/flash-test/)?
      swapVideo(video, $(mp4).attr('src'), player, skin) unless supported


swapVideo = (video, mp4, player, skin) ->
  id = 'video_'+Math.round(1 + Math.random()*(100000))
  width = parseInt(video.attr('width'), 10) or video.width()
  height = parseInt(video.attr('height'), 10) or video.height()
  swfobject = require 'video/swfobject'
  ratio = (height/width*100)+'%'
  
  video.after '<div class="flash-video"><div style="padding: 29px 0 '+ratio+';" class="swfobject"><div id='+id+'>'

  swfobject.embedSWF(
    player, id, width, height, "9.0.0",
    { file : mp4, image : video.attr('poster'), skin : skin },
    { movie : mp4, wmode : "opaque", allowfullscreen : "true" }
  )
  video.remove()

module.exports = swfSwap

