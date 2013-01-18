wrap = require '../lib/index'

describe 'Snockets', ->
  it 'should wrap correctly without shortcut', (done) ->
    asset = new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
    }
    asset.on 'error', (err) ->
      throw err
    asset.on 'complete', ->
      asset.md5.should.equal 'b01b34326cd38ea077632ab9b98a911a'
      done()
    asset.wrap()
  it 'should wrap correctly', (done) ->
    asset = new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
    }, (err, asset) ->
      asset.md5.should.equal 'b01b34326cd38ea077632ab9b98a911a'
      done()
  it 'should wrap on callback', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
    }, (err, asset) ->
      asset.md5.should.equal 'b01b34326cd38ea077632ab9b98a911a'
      done()
  it 'should be able to compress', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/hello.coffee"
      compress: true
    }, (err, asset) ->
      asset.md5.should.equal '9551f30bcd070f86e9e361ddba928293'
      done()
   it 'should be able to concat', (done) ->
    new wrap.Snockets {
      src: "#{__dirname}/assets/concat.coffee"
      compress: true
    }, (err, asset) ->
      asset.md5.should.equal '34133b64b48b4dbddb322915374f819e'
      done()
     
