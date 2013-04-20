# Title: Simple Video tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Easily output MPEG4 HTML5 video with a flash backup.

module Jekyll

  class VideoTag < Liquid::Tag
    @video = nil
    @poster = ''
    @height = ''
    @width = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(\S+\.\S+)(\s+(\S+\.\S+))?(\s+(\S+\.\S+))?(\s+(\d+)\s(\d+))?(\s+(\S+\.\S+))?/i
        @video  = [$1, $3, $5].compact
        @width  = $7
        @height = $8
        @poster = $10
      end
      super
    end

    def render(context)
      output = super
      type = {
        'mp4' => "type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'",
        'ogv' => "type='video/ogg; codecs=theora, vorbis'",
        'webm' => "type='video/webm; codecs=vp8, vorbis'"
      }
      if @video && @video.size > 0
        video =  "<video width='#{@width}' height='#{@height}' preload='none' controls poster='#{@poster}'>"
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

Liquid::Template.register_tag('video', Jekyll::VideoTag)

