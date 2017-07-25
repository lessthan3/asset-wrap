wrap = require '../lib/index'

describe 'Coffee', ->

  it 'should wrap correctly without shortcut', (done) ->
    asset = new wrap.Coffee {
      src: "#{__dirname}/assets/hello.coffee"
    }
    asset.on 'error', (err) ->
      throw err
    asset.on 'complete', ->
      asset.md5.should.equal 'fe2984bb8ff29d0fd26a598b090f465b'
      done()
    asset.wrap()

  it 'should wrap correctly', (done) ->
    asset = new wrap.Coffee {
      src: "#{__dirname}/assets/hello.coffee"
    }, (err) ->
      throw err if err
      asset.md5.should.equal 'fe2984bb8ff29d0fd26a598b090f465b'
      done()

  it 'should wrap on callback', (done) ->
    asset = new wrap.Coffee {
      src: "#{__dirname}/assets/hello.coffee"
    }, (err) ->
      throw err if err
      asset.md5.should.equal 'fe2984bb8ff29d0fd26a598b090f465b'
      done()

  it 'should be able to compress', (done) ->
    asset = new wrap.Coffee {
      src: "#{__dirname}/assets/hello.coffee"
      compress: true
    }, (err) ->
      throw err if err
      asset.md5.should.equal 'fe2984bb8ff29d0fd26a598b090f465b'
      done()

  it 'should be able to generate source maps', (done) ->
    asset = new wrap.Coffee {
      src: "#{__dirname}/assets/hello.coffee"
      source_map: true
    }, (err) ->
      throw err if err
      asset.should.have.property 'source_map'
      asset.should.have.property 'v3_source_map'
      asset.md5.should.equal 'fe2984bb8ff29d0fd26a598b090f465b'
      done()
