require "octopress-video-tag/version"

module Octopress
  module Tags
    module VideoTag
      class Tag < Liquid::Tag
        @video   = nil
        @poster  = ''
        @height  = ''
        @width   = ''
        Preload  = /(:?preload: *(:?\S+))/i
        Size     = /\s(auto|\d\S+)\s?(auto|\d\S+)?/i
        URLs     = /((https?:\/)?\/\S+)/i

        def initialize(tag_name, tag_markup, tokens)
          @markup = tag_markup
          markup = tag_markup.dup

          @preload = markup.scan(Preload).flatten.compact.last || "metadata"
          markup.sub!(Preload, '')

          @sizes = markup.scan(Size).flatten.compact
          markup.sub!(Size, '')

          urls = markup.scan(URLs).map{ |m| m.first }
          @videos = urls.select {|u| u.match /mp4|ogv|webm/i}
          @poster = urls.select {|u| u.match /jpe?g|png|gif/i}.first
          markup.gsub!(URLs, '')

          if !(@classes = markup.strip).empty?
            @classes = "class='#{@classes}' "
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

          if context.environments.first['site']['click_to_play_video'] != false
            clickToPlay = "onclick='(function(el){ if(el.paused) el.play(); else el.pause() })(this)'"
          else
            clickToPlay = ''
          end

          if @videos && @videos.size > 0
            video =  "<video #{@classes}controls poster='#{@poster}' width='#{@sizes[0]}' height='#{@sizes[1]}' preload='#{@preload}' #{clickToPlay}>"
            @videos.each do |v|
              t = v.match(/([^\.]+)$/)[1]
              video += "<source src='#{v}' #{type[t]}>"
            end
            video += "</video>"
          else
            raise "No video mp4, ogv, or webm urls found in {% video #{@markup} %}"
          end
        end
      end
    end
  end
end

Liquid::Template.register_tag('video', Octopress::Tags::VideoTag::Tag)


if defined? Octopress::Docs
  Octopress::Docs.add({
    name:        "Octopress Video Tag",
    gem:         "octopress-video-tag",
    version:     Octopress::Tags::VideoTag::VERSION,
    description: "Easy HTML5 video tags for Jekyll sites",
    path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
    source_url:  "https://github.com/octopress/video-tag",
  })
end

