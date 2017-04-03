wrap = require '../lib/index'

describe 'Asset', ->

  it 'should wrap correctly without shortcut', (done) ->
    asset = new wrap.Asset {
      src: "#{__dirname}/assets/hello.coffee"
    }
    asset.on 'error', (err) ->
      throw err
    asset.on 'complete', ->
      asset.md5.should.equal 'f942df5dab08c375956ee77b6a5c5fbd'
      done()
    asset.wrap()

  it 'should wrap on callback', (done) ->
    asset = new wrap.Asset {
      src: "#{__dirname}/assets/hello.coffee"
    }, (err) ->
      throw err if err
      asset.md5.should.equal 'f942df5dab08c375956ee77b6a5c5fbd'
      done()
