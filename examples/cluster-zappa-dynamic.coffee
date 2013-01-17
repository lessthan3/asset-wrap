cluster = require 'cluster'
os      = require 'os'

if cluster.isMaster
  # Fork workers
  cluster.fork() for i in os.cpus()
  cluster.on 'exit', (worker, code, signal) ->
    console.log "worker #{worker.process.pid} died"
else
  # Workers can share any TCP connection
  require('zappajs') ->
    wrap = require '../lib/index'

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
          a href: '/js/hello.js', ->
            'View Javascript'

