# Octopress Video Tag

Easy HTML5 video tags for Jekyll sites.

[![Build Status](http://img.shields.io/travis/octopress/video-tag.svg)](https://travis-ci.org/octopress/video-tag)
[![Gem Version](http://img.shields.io/gem/v/octopress-video-tag.svg)](https://rubygems.org/gems/octopress-video-tag)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://octopress.mit-license.org)

## Installation

### Using Bundler

Add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-video-tag'
    end

Then install the gem with Bundler

    $ bundle

### Manual Installation

    $ gem install octopress-video-tag

Then add the gem to your Jekyll configuration.

    gems:
      -octopress-video-tag

## Syntax

Creating a proper HTML5 video tag couldn't be simpler.

    {% video urls [class names] [width height] [preload:auto|metadata|none] %}

### URLs

URLs must include a protocol `http` or `https` or begin with a `/`. URLs for videos should point to mp4, ogv, and/or webm. Adding a url to an image will set that image as the video's poster frame.

### Preload

Preload has three settings:

- `auto` - The Video should start downloading when the page is loaded.
- `metadata` - Only the videos metadata is downloaded when the page is loaded.
- `none` - The video will only be downloaded when the viewer clicks.

This plugin defaults to preloading `metadata`. This uses minimal bandwidth while still allowing the video to start playing quickly.

### Click to play

Each video is embedded with a minuscule bit of javascript which plays videos when they are clicked. If you'd prefer to disable this feature, set `click_to_play_video: false` in your site's configuration.

## Examples:

```
{% video {{ site.cdn }}/videos/clouds.mp4 %}
{% video featured wide /images/clouds.jpg /videos/clouds.mp4 /videos/clouds.webm /videos/clouds.ogv 1080px 608px preload:auto %}
```

This would output the following HTML

```html
<video controls preload='metadata' onclick='(function(el){ if(el.paused) el.play(); else el.pause() })(this)'>
  <source src='https://cdn.com/video/clouds.mp4' type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
</video>

<video class='featured wide' controls poster='/images/clouds.jpg' width='1080px' height='608px' preload='auto'
  onclick='(function(el){ if(el.paused) el.play(); else el.pause() })(this)'>
  <source src='/videos/clouds.mp4' type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
  <source src='/videos/clouds.webm' type='video/webm; codecs="vp8, vorbis"'>
  <source src='/videos/clouds.ogv' type='video/ogg; codecs="theora, vorbis"'>
</video>
```

<video controls poster='http://s3.imathis.com/video/clouds.jpg' width='' height='' preload='metadata' onclick='(function(el){ if(el.paused) el.play(); else el.pause() })(this)'>
  <source src='http://s3.imathis.com/video/clouds.mp4' type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
  <source src='http://s3.imathis.com/video/clouds.webm' type='video/webm; codecs="vp8, vorbis"'>
  <source src='http://s3.imathis.com/video/clouds.ogv' type='video/ogg; codecs="theora, vorbis"'>
</video>

## Contributing

1. Fork it ( https://github.com/octopress/video-tag/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
