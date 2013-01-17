less = require 'less'
fs = require 'fs'
path = require 'path'
Asset = require('../wrap').Asset

class exports.LessAsset extends Asset
  type: 'text/css'
  wrap: ->
    compress = @config.compress or false
    paths = @config.paths or []

    fs.readFile @src, 'utf8', (err, data) =>
      return @emit 'error', err if err?
      parser = new less.Parser
        filename: @src
        paths: paths.concat[path.dirname(@src)]
      parser.parse data, (err, tree) =>
        return @emit 'error', err if err?
        @data = tree.toCSS compress: @compress
        @emit 'complete'

