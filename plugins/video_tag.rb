# Title: Simple Video tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Easily write HTML5 video (mp4,webm,ogv) with a flash backup.

module Octopress
  class VideoTag < Liquid::Tag
    @video   = nil
    @poster  = ''
    @height  = ''
    @width   = ''
    Poster   = /(:?[^ ]+\.(jpg|jpeg|gif|png))/i
    Preload  = /(:?preload: *(:?\S+))/i

    def initialize(tag_name, markup, tokens)
      @preload = "none"
      if markup =~ Poster
        @poster = $1
      end
      markup = markup.sub(Poster, '').strip

      if markup =~ Preload
        @preload =  $2
      end
      markup = markup.sub(Preload, '').strip

      if markup =~ Poster
        @poster = $1
      end
      markup = markup.sub(Poster, '').strip

      if markup =~ /(\S+\.\S+)(\s+(\S+\.\S+))?(\s+(\S+\.\S+))?(\s+(\d+)\s(\d+))?/i
        @video  = [$1, $3, $5].compact
        @width  = $7
        @height = $8
      end
      super
    end

    def render(context)
      output = super
      type = {
        'mp4' => "type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'",
        'ogv' => "type='video/ogg; codecs=\"theora, vorbis\"'",
        'webm' => "type='video/webm; codecs=\"vp8, vorbis\"'"
      }
      if @video && @video.size > 0
        video =  "<video controls poster='#{@poster}' width='#{@width}' height='#{@height}' preload='#{@preload}'>"
        @video.each do |v|
          t = v.match(/([^\.]+)$/)[1]
          video += "<source src='#{v}' #{type[t]}>"
        end
        video += "</video>"
      else
        "Error processing input, expected syntax: {% video url/to/video [url/to/video] [url/to/video] [width height] [url/to/poster] %}"
      end
    end
  end
end

Liquid::Template.register_tag('video', Octopress::VideoTag)

