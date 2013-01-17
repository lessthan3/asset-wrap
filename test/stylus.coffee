assert = require 'assert'
wrap = require '../lib/index'

describe 'Stylus', ->
  it 'should wrap correctly', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
      dst: '/js/app.css'
    }
    asset.on 'complete', () ->
      assert.equal asset.md5, '1e15bb925b5421b697e68a582b9b9fd3'
      done()
    asset.wrap()
  it 'should wrap on callback', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
      dst: '/js/app.css'
    }, (asset) ->
      assert.equal asset.md5, '1e15bb925b5421b697e68a582b9b9fd3'
      done()
  it 'should be able to compress', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
      dst: '/js/app.css'
      compress: true
    }, (asset) ->
      assert.equal asset.md5, 'd4db8e58738b54a8cf8952ce4214b794'
      done()
  it 'should be able to concat', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/concat.styl"
      dst: '/js/app.css'
      compress: true
    }, (asset) ->
      assert.equal asset.md5, '2c99b08b9974d9f21d63de82860e280b'
      done()

