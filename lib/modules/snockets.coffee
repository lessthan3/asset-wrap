
# dependencies
chokidar = require 'chokidar'
path = require('path')
Snockets = require 'snockets'
Asset = require('../asset').Asset

# asset
class exports.SnocketsAsset extends Asset
  ext: 'js'
  name: 'snockets'
  type: 'text/javascript'
  constructor: (@config, callback) ->
    super @config, callback
    @snockets = new Snockets()
  compile: ->
    @snockets.getConcatenation @src, {
      async: false
      minify: @config.compress or false
    }, (err, js) =>
      return @emit 'error', err if err?
      @data = js
      @emit 'compiled'
  watch: ->
    @snockets.scan @src, (err, graph) =>
      for file in graph.getChain @src
        watcher = chokidar.watch file, {ignored: /^\./, persistent: false}
        watcher.on 'change', (path, stats) =>
          console.log "asset.wrap[snockets] file changed: #{path}"
          @compile()
