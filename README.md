# Wrap Multiple Assets
```
wrap = require 'asset-wrap'
assets = wrap.AssetWrap [
  new wrap.Stylus {
    src: "#{__dirname}/path/to/app.styl"
    dst: '/css/app.css'
    compress: true
  }
  new wrap.Snockets {
    src: "#{__dirname}/path/to/app.coffee"
    dst: '/js/app.js'
    compress: false
  }
], {
  AmazonS3:
    key: ''
    secret: ''
  CloudFiles:
    key: ''
    secret: ''
}

assets.on 'complete', () ->
  console.log 'assets compiled'

app.configure () ->
  app.use assets.middleware

@get '/': ->
  @render index: {
    assets: assets
  }

@view index: ->
  head ->
    @assets.tag '/css/app.css'
    @assets.tag '/js/app.js'

# Wrap Single Asset - Wrap explicitly
wrap = require '../src/wrap'
asset = new wrap.Snockets {
  src: "#{__dirname}/test.coffee"
  dst: '/js/app.js'
}
asset.on 'complete', () ->
  console.log asset.src
  console.log asset.dst
  console.log asset.md5
  console.log asset.url
  console.log asset.data
  console.log asset.tag
asset.wrap()

# Wrap Single Asset - Wrap on Construction
asset = new wrap.Snockets {
  src: "#{__dirname}/test.coffee"
  dst: '/js/app.js'
}, (asset) ->
  console.log asset.src
  console.log asset.dst
  console.log asset.md5
  console.log asset.url
  console.log asset.data
  console.log asset.tag


# Wrap Single Asset with Zappa
@get '/js/app.js': ->
  new wrap.Snockets {
    url: '/js/app.js'
    src: "#{__dirname}/path/to/app.coffee"
  }, (asset) =>
    @response.setHeader 'Content-Type', 'text/javascript'
    @response.write asset.data
