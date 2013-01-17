async = require 'async'
EventEmitter = require('events').EventEmitter

class exports.Assets extends EventEmitter
  constructor: (assets) ->
    @cache = {}
    process.nextTick =>
      async.forEach assets, (asset, next) ->
        asset.on 'complete', ->
          @cache[asset.url] = asset
          next()
        asset.wrap()
      , (err) =>
        return @emit 'error', err if err?
        @emit 'complete'

  middleware: (req, res, next) ->
    asset = @cache[req.url]
    return next() unless asset?
    res.header 'Content-Type', asset.type
    res.send asset.data

  push: (host, config) ->
    switch host
      when 's3'
        console.log 's3'
      when 'cloudfiles'
        console.log 'cloudfiles'

  tag: (dst) ->
    @cache[dst].tag

  wrap: ->
    throw new Error 'override me!'

