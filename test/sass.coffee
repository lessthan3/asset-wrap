assert = require 'assert'
wrap = require '../lib/index'

describe 'Sass', ->
  it 'should wrap correctly', (done) ->
    asset = new wrap.Sass {
      src: "#{__dirname}/assets/hello.sass"
      dst: '/js/app.css'
    }
    asset.on 'complete', () ->
      assert.equal asset.md5, '2228e977ebea8966e27929f43e39cb67'
      done()
    asset.wrap()

