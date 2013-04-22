---
layout: page
title: "Docs for video-tag plugin"
date: 2013-04-20T20:48:11-05:00
---

This plugin makes it easy to insert mp4 encoded HTML5 videos in a post. Octopress ships with javascripts which
detect mp4 video support ([using Modernizr](http://modernizr.com)) and automatically offer a flash player fallback.

#### Syntax

    {{ "{% video url/to/video.mp4 [url/to/video.webm] [url/to/video.ogv] [width height] [url/to/poster]" }} %}

#### Example

    {% raw %}
    {% video http://s3.imathis.com/video/clouds.mp4 http://s3.imathis.com/video/clouds.webm http://s3.imathis.com/video/clouds.ogv 1080 608 http://s3.imathis.com/video/clouds.jpg %}{% endraw %}


{% video http://s3.imathis.com/video/clouds.mp4 http://s3.imathis.com/video/clouds.webm http://s3.imathis.com/video/clouds.ogv 1080 608 http://s3.imathis.com/video/clouds.jpg %}

<p>You're probably using a browser which supports HTML5 video and you're looking at this page wondering if it really works.
Reloading the page with the url hash <a href="#flash-test">#flash-test</a> and you'll get to see the flash player fallback.</p>
