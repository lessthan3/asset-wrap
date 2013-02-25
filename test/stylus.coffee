wrap = require '../lib/index'

describe 'Stylus', ->
  it 'should wrap correctly without shortcut', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
    }
    asset.on 'error', (err) ->
      throw err
    asset.on 'complete', ->
      done()
    asset.wrap()
  it 'should wrap correctly', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
    }, (err) ->
      asset.md5.should.equal '1e15bb925b5421b697e68a582b9b9fd3'
      done()
  it 'should wrap on callback', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
    }, (err) ->
      asset.md5.should.equal '1e15bb925b5421b697e68a582b9b9fd3'
      done()
  it 'should be able to compress', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
      compress: true
    }, (err) ->
      asset.md5.should.equal 'b53eac41377b9ee809fd1c83e903017b'
      done()
  it 'should be able to concat', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/concat.styl"
      compress: true
    }, (err) ->
      asset.md5.should.equal '5b4bb8f2ea7b82a3f0c16a09ad7b8656'
      done()
  it 'should be able to import nib', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/nib-test.styl"
    }, (err) ->
      asset.md5.should.equal 'a2e33d772ec8ef1770ed5a4d2646efb0'
      done()
  it 'should throw a file not found error', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/not-a-file.styl"
    }, (err, asset) ->
      err.errno.should.equal 34
      done()


