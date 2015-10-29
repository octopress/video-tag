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
        Sizes    = /\s(auto|\d\S+)\s/i
        Poster   = /((https?:\/\/|\/)\S+\.(png|gif|jpe?g)\S*)/i
        Videos   = /((https?:\/\/|\/)\S+\.(webm|ogv|mp4)\S*)/i
        Attrs    = /(loop|nocontrols|autoplay|muted)/i
        Types    = {
          '.mp4' => "type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'",
          '.ogv' => "type='video/ogg; codecs=\"theora, vorbis\"'",
          '.webm' => "type='video/webm; codecs=\"vp8, vorbis\"'"
        }

        def initialize(tag_name, tag_markup, tokens)
          @markup = tag_markup
          super
        end

        def render(context)
          @markup = process_liquid(context)

          if sources.size > 0
            video =  "<video #{attributes} #{classes} #{poster} #{sizes} #{preload} #{click_to_play(context)}>"
            video << sources
            video << "</video>"
          else
            raise "No video mp4, ogv, or webm urls found in {% video #{@markup} %}"
          end
        end

        def click_to_play(context)
          if context.environments.first['site']['click_to_play_video'] != false
            "onclick='(function(el){ if(el.paused) el.play(); else el.pause() })(this)'"
          end
        end

        def sources
          @markup.scan(Videos).map(&:first).compact.map do |v|
            "<source src='#{v}' #{Types[File.extname(v)]}>"
          end.join('')
        end

        def poster
          p = @markup.scan(Poster).map(&:first).compact.first
          "poster='#{p}'" if p
        end

        def sizes
          s = @markup.scan(Sizes).map(&:first).compact
          attrs = "width='#{s[0]}'" if s[0]
          attrs += " height='#{s[1]}'" if s[1]
          attrs
        end

        def preload
          if p = @markup.scan(Preload).flatten.last || "metadata"
            "preload='#{p}'"
          end
        end

        def classes
          classes = @markup.sub(Preload, '').gsub(Videos, '').sub(Poster, '').gsub(Attrs,'').gsub(Sizes, '').strip

          if !classes.empty?
            "class='#{classes}'"
          end
        end

        def attributes
          attrs = @markup.gsub(Videos, '').sub(Poster, '').strip

          # Only keep valid attributes
          attrs = attrs.split(" ").select { |e| Attrs =~ e }

          # Add controls attribute if nocontrols doesn't exist
          unless attrs.delete("nocontrols") != nil
            attrs.push "controls"
          end

          attrs = attrs.join(" ")

          if !attrs.empty?
            "#{attrs}"
          end
        end

        def process_liquid(context)
          Liquid::Template.parse(@markup).render!(context.environments.first)
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

