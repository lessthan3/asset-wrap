
# dependencies
fs = require 'fs'
path = require 'path'
nib = require 'nib'
stylus = require 'stylus'
Asset = require('../asset').Asset
CleanCSS = require 'clean-css'

# asset
class exports.StylusAsset extends Asset
  ext: 'css'
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
      s = stylus(data, options)
        .use(nib())
        .define('url', stylus.url())
        .set('compress', compress)
        .set('include css', true)
      @parseVariables s, @config.vars, @config.vars_prefix
      s.render (err, css) =>
          return @emit 'error', err if err?
          if @config.cleancss
            css = new CleanCSS({}).minify css
          @data = css
          @emit 'compiled'

  parseVariables: (s, vars, vars_prefix="") ->
    parseColors = (colors) ->
      parse = (hex) ->
        hex = "#{hex}#{hex}" if hex.length == 1
        parseInt hex, 16

      rgba = [0, 0, 0, 255]
      rgba[index] = parse color for index, color of colors
      new stylus.nodes.RGBA rgba[0], rgba[1], rgba[2], rgba[3]/255

    for k, v of vars
      if vars_prefix
       k = "#{vars_prefix}#{k}"

      # boolean
      if v in ['true', 'false']
        s.define k, new stylus.nodes.Boolean v is 'true'

      # shorthand rgb
      else if /^#(?:([0-9a-fA-F]){3})$/.test v
        rgb = v.match /^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/
        s.define k, parseColors rgb[1..3]

      # shorthand rgba
      else if /^#(?:([0-9a-fA-F]){4})$/.test v
        rgba = v.match /^#([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F])$/
        s.define k, parseColors rgb[1..4]

      # rgb
      else if /^#(?:([0-9a-fA-F]){6})$/.test v
        rgb = v.match /^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$/
        s.define k, parseColors rgb[1..3]

      # rgba
      else if /^#(?:([0-9a-fA-F]){8})$/.test v
        rgba = v.match /^#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$/
        s.define k, parseColors rgba[1..4]

      # literal
      else
        s.define k, new stylus.nodes.Literal v
