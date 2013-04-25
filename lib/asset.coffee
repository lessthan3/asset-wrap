chokidar = require 'chokidar'
crypto = require 'crypto'
path = require 'path'
EventEmitter = require('events').EventEmitter

class exports.Asset extends EventEmitter
  name: 'asset'
  constructor: (@config, callback) ->
    throw new Error 'must provide config' if not @config?
    @src = @config.src or throw new Error 'must provide src parameter'
    @dst = @config.dst or @src
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
          @tag = "<link type='text/css' rel='stylesheet' href='#{@url}' />"
        else
          @tag = @url
      if @config.cache
        @cache = "public, max-age=#{@config.cache}, must-revalidate"
      else
        @cache = "private, max-age=0, no-cache, no-store, must-revalidate"
    super()
    if callback
      process.nextTick =>
        @on 'complete', =>
          callback null
        @on 'error', (err) =>
          callback err
        @wrap()
  compile: ->
    throw new Error 'override me!'
  watch: ->
    watcher = chokidar.watch @src, {ignored: /^\./, persistent: false}
    watcher.on 'change', (path, stats) =>
      console.log "asset.wrap[#{@name}] file changed: #{path}"
      @compile()
  wrap: ->
    @compile()
    @watch() if @config.watch

