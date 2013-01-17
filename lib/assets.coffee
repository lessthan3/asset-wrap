async = require 'async'
EventEmitter = require('events').EventEmitter

class exports.Assets extends EventEmitter
  constructor: (assets) ->
    @dsts = {}
    @urls = {}
    process.nextTick =>
      async.forEach assets, (asset, next) =>
        asset.on 'complete', =>
          @dsts[asset.dst] = asset
          @urls[asset.url] = asset
          next()
        asset.wrap()
      , (err) =>
        return @emit 'error', err if err?
        @emit 'complete'

  middleware: (req, res, next) =>
    asset = @urls[req.url]
    return next() unless asset?
    res.header 'Content-Type', asset.type
    res.send asset.data

  push: (host, config) ->
    switch host
      when 's3'
        console.log 's3'
      when 'cloudfiles'
        console.log 'cloudfiles'

  # Shortcuts
  data: (dst) ->  @dsts[dst].data
  get: (dst) ->   @dsts[dst]
  md5: (dst) ->   @dsts[dst].md5
  src: (dst) ->   @dsts[dst].src
  tag: (dst) ->   @dsts[dst].tag
  url: (dst) ->   @dsts[dst].url

