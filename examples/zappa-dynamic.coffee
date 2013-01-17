require('zappajs') ->
  wrap = require '../lib/index'

  @get '/css/hello.css': ->
    new wrap.Stylus {
      src: 'assets/hello.styl'
      dst: '/css/hello.css'
      compress: true
    }, (asset) =>
      @response.setHeader 'ContentType', asset.type
      @response.send asset.data
 
  @get '/js/hello.js': ->
    new wrap.Snockets {
      src: 'assets/hello.coffee'
      dst: '/js/hello.js'
      compress: true
    }, (asset) =>
      @response.setHeader 'ContentType', asset.type
      @response.send asset.data

  @get '/': ->
    @render 'index': {layout: no}

  @view index: ->
    body ->
      div ->
        a href: '/css/hello.css', ->
          'View CSS'
      div ->
        a href: '/js/hello.js', ->
          'View Javascript'

