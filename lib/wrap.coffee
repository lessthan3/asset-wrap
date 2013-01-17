async = require 'async'
crypto = require 'crypto'
path = require 'path'
EventEmitter = require('events').EventEmitter

class Assets extends EventEmitter
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

class Asset extends EventEmitter
  constructor: (@config, callback) ->
    throw new Error 'must provide config' if not @config?
    @src = @config.src or throw new Error 'must provide src parameter'
    @dst = @config.dst or throw new Error 'must provide dst parameter'
    @on 'newListener', (event, listener) =>
      listener() if event == 'complete' and @data?
    @on 'complete', =>
      @md5 = crypto.createHash('md5').update(@data).digest 'hex'
      @ext = path.extname @dst
      @url = "#{@dst.slice(0, @dst.length - @ext.length)}-#{@md5}#{@ext}"
      switch @type
        when 'text/javascript'
          @tag = "<script type='text/javascript' src='#{@url}'></script>"
        when 'text/css'
          @tag = "<link ref='stylesheet' href='#{@url}' />"
        else
          @tag = @url
      callback @ if callback
    super()
    @wrap() if callback

  wrap: ->
    throw new Error 'override me!'
exports.Assets = Assets
exports.Asset = Asset
exports.Less = require('./assets/less').LessAsset
exports.Snockets = require('./assets/snockets').SnocketsAsset
exports.Stylus = require('./assets/stylus').StylusAsset
