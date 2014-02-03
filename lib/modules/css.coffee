
# dependencies
fs = require 'fs'
path = require 'path'
Asset = require('../asset').Asset
CleanCSS = require 'clean-css'

# asset
class exports.CSSAsset extends Asset
  ext: 'css'
  name: 'css'
  type: 'text/css'
  compile: ->
    fs.readFile @src, 'utf8', (err, css) =>
      return @emit 'error', err if err?

      if @config.cleancss or @config.compress or @config.minify
        css = new CleanCSS({}).minify css

      @data = css
      @emit 'compiled'

