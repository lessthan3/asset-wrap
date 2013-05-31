chokidar = require 'chokidar'
crypto = require 'crypto'
path = require 'path'
pkgcloud = require 'pkgcloud'
utils = require './utils'

EventEmitter = require('events').EventEmitter

class exports.Asset extends EventEmitter
  name: 'asset'
  ext: ''
  type: ''

  constructor: (@config, callback) ->
    throw new Error 'must provide config' if not @config?
    @src = @config.src or throw new Error 'must provide src parameter'
    @dst = @config.dst or @src
    @on 'compiled', @onCompiled
    super()

    # wrap shortcut callback
    if callback
      process.nextTick =>
        @on 'complete', =>
          callback null
        @on 'error', (err) =>
          callback err
        @wrap()

  # events
  onCompiled: =>
    
    # set url
    @md5 = crypto.createHash('md5').update(@data).digest 'hex'
    @url = "#{@dst[0...@dst.length-path.extname(@dst).length]}-#{@md5}.#{@ext}"

    # tag for html templates
    switch @type
      when 'text/javascript'
        @tag = "<script type='text/javascript' src='#{@url}'></script>"
      when 'text/css'
        @tag = "<link type='text/css' rel='stylesheet' href='#{@url}' />"
      else
        @tag = @url

    # cache headers
    if @config.cache
      @cache = "public, max-age=#{@config.cache}, must-revalidate"
    else
      @cache = "private, max-age=0, no-cache, no-store, must-revalidate"

    # deploy to cdn
    if @config.cdn
      @push @config.cdn, =>
        @emit 'complete'
    else
      @emit 'complete'

  # compile this asset
  compile: ->
    throw new Error 'override me!'

  # push this asset to a cdn
  push: (config, next) ->
    client = pkgcloud.storage.createClient config
    client.getContainer config.container, (err, container) =>
      stream = new utils.BufferStream @data
      stream.pipe client.upload {
        container: container
        remote: @url
      }, =>
        @url = "#{config.cname}/#{@url}"
        next()

  # watch this asset for any changes
  watch: ->
    watcher = chokidar.watch @src, {ignored: /^\./, persistent: false}
    watcher.on 'change', (path, stats) =>
      console.log "asset.wrap[#{@name}] file changed: #{path}"
      @compile()

  # wrap this asset
  wrap: ->
    @compile()
    @watch() if @config.watch

