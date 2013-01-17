wrap = require '../lib/index'
assert = require 'assert'

describe 'Snockets', ->
  it 'should wrap correctly', (done) ->
    asset = new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
      dst: '/js/app.js'
    }
    asset.on 'complete', () ->
      assert.equal asset.md5, 'b01b34326cd38ea077632ab9b98a911a'
      done()
    asset.wrap()
  it 'should wrap on callback', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
      dst: '/js/app.js'
    }, (asset) ->
      assert.equal asset.md5, 'b01b34326cd38ea077632ab9b98a911a'
      done()
  it 'should be able to compress', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
      dst: '/js/app.js'
      compress: true
    }, (asset) ->
      assert.equal asset.md5, '9551f30bcd070f86e9e361ddba928293'
      done()
   it 'should be able to concat', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/concat.coffee"
      dst: '/js/app.js'
      compress: true
    }, (asset) ->
      assert.equal asset.md5, '34133b64b48b4dbddb322915374f819e'
      done()
     
