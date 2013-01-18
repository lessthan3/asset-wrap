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
    }, (err, asset) ->
      asset.md5.should.equal '1e15bb925b5421b697e68a582b9b9fd3'
      done()
  it 'should wrap on callback', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
    }, (err, asset) ->
      asset.md5.should.equal '1e15bb925b5421b697e68a582b9b9fd3'
      done()
  it 'should be able to compress', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/hello.styl"
      compress: true
    }, (err, asset) ->
      asset.md5.should.equal 'd4db8e58738b54a8cf8952ce4214b794'
      done()
  it 'should be able to concat', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/concat.styl"
      compress: true
    }, (err, asset) ->
      asset.md5.should.equal '2c99b08b9974d9f21d63de82860e280b'
      done()
  it 'should be able to import nib', (done) ->
    new wrap.Stylus {
      src: "#{__dirname}/assets/nib-test.styl"
    }, (err, asset) ->
      asset.md5.should.equal 'a2e33d772ec8ef1770ed5a4d2646efb0'
      done()
  it 'should throw a file not found error', (done) ->
    asset = new wrap.Stylus {
      src: "#{__dirname}/assets/not-a-file.styl"
    }, (err, asset) ->
      err.errno.should.equal 34
      done()


