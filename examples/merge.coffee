wrap = require '../lib/index'

new wrap.Assets [
  new wrap.Snockets {
    src: 'assets/hello.coffee'
    compress: true
  }
  new wrap.Snockets {
    src: 'assets/goodbye.coffee'
    compress: true
  }
], (assets) ->
  asset = assets.merge()
  console.log asset.data

