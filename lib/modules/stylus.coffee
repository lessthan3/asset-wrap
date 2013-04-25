cleancss = require 'clean-css'
fs = require 'fs'
path = require 'path'
nib = require 'nib'
stylus = require 'stylus'
Asset = require('../asset').Asset

class exports.StylusAsset extends Asset
  name: 'stylus'
  type: 'text/css'
  compile: ->
    compress = @config.compress or false
    paths = @config.paths or []

    fs.readFile @src, 'utf8', (err, data) =>
      return @emit 'error', err if err?
      options =
        filename: @src
        paths: paths.concat [path.dirname @src]
      stylus(data, options)
        .use(nib())
        .set('compress', compress)
        .set('include css', true)
        .render (err, css) =>
          return @emit 'error', err if err?
          css = cleancss.process css if @config.cleancss
          @data = css
          @emit 'complete'
