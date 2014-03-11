
# dependencies
fs = require 'fs'
path = require 'path'
nib = require 'nib'
sass = require 'sass'
Asset = require('../asset').Asset

# asset
class exports.SassAsset extends Asset
  ext: 'css'
  name: 'sass'
  type: 'text/css'
  compile: ->

    # read source
    @read (err, source) =>
      return @emit 'error', err if err

      # pre-process
      if @config.preprocess
        source = @config.preprocess source

      # compile
      result = sass.render source

      # post-process
      if @config.postprocess
        result = @config.postprocess result

      # complete
      @data = result
      @emit 'compiled'
