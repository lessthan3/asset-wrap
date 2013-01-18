assert = require 'assert'
wrap = require '../lib/index'

describe 'Less', ->
  it 'should wrap correctly', (done) ->
    asset = new wrap.Less {
      src: "#{__dirname}/assets/hello.less"
    }
    asset.on 'complete', () ->
      assert.equal asset.md5, '9568dd9e0d5b126af4fb9f7505b10934'
      done()
    asset.wrap()
  it 'should wrap on callback', (done) ->
    new wrap.Less {
      src: "#{__dirname}/assets/hello.less"
    }, (asset) ->
      assert.equal asset.md5, '9568dd9e0d5b126af4fb9f7505b10934'
      done()
  it 'should be able to compress', (done) ->
    new wrap.Less {
      src: "#{__dirname}/assets/hello.less"
      compress: true
    }, (asset) ->
      assert.equal asset.md5, '1f1654586705c11ce56755318b715379'
      done()
  it 'should be able to concat', (done) ->
    new wrap.Less {
      src: "#{__dirname}/assets/concat.less"
    }, (asset) ->
      assert.equal asset.md5, '2c99b08b9974d9f21d63de82860e280b'
      done()

