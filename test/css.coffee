wrap = require '../lib/index'

describe 'CSS', ->

  it 'should wrap correctly without shortcut', (done) ->
    asset = new wrap.CSS {
      src: "#{__dirname}/assets/hello.css"
    }
    asset.on 'error', (err) ->
      throw err
    asset.on 'complete', ->
      asset.md5.should.equal '3c130f32f774c4edf102c339d0439df0'
      done()
    asset.wrap()

  it 'should wrap correctly', (done) ->
    asset = new wrap.CSS {
      src: "#{__dirname}/assets/hello.css"
    }, (err) ->
      throw err if err
      asset.md5.should.equal '3c130f32f774c4edf102c339d0439df0'
      done()

  it 'should minify correctly', (done) ->
    asset = new wrap.CSS {
      src: "#{__dirname}/assets/hello.css"
      minify: true
    }, (err) ->
      throw err if err
      asset.md5.should.equal 'b53eac41377b9ee809fd1c83e903017b'
      done()

