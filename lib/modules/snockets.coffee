path = require('path')
Snockets = require 'snockets'
Asset = require('../asset').Asset

class exports.SnocketsAsset extends Asset
  type: 'text/javascript'
  wrap: ->
    compress = @config.compress or false

    snockets = new Snockets()
    snockets.getConcatenation @src, {
      minify: compress
    }, (err, js) =>
      return @emit 'error', err if err?
      @data = js
      @emit 'complete'
