fs = require 'fs'
path = require 'path'
nib = require 'nib'
sass = require 'sass'
Asset = require('../asset').Asset

class exports.SassAsset extends Asset
  type: 'text/css'
  wrap: ->
    compress = @config.compress or false
    paths = @config.paths or []

    fs.readFile @src, 'utf8', (err, data) =>
      return @emit 'error', err if err?
      @data = sass.render data
      @emit 'complete'
