Asset-Wrap is a simple asset manager for node.

## Goals
1. build at anytime (server start and middlewareor on dynamically on any route)
2. support stylus, less, and sass
3. support snockets for coffee-script/coffeecup
4. use async whenever possible
5. support cluster
6. easily extendible (just add another module)
7. watch for file changes
8. TODO: ability to serve file from s3 or cloudfiles

## Install
```
npm install asset-wrap
```

## Details
### Asset
A wrapped asset, whether using snockets, stylus, sass, or less.

All assets require at a minimum one parameter
* `src`: the path to your source file

Most of the time you'll always want to include the `dst` parameter. defaults to `src` if not provided
* `dst`: the location to serve your file from (without the md5 appended yet)

After "wrapping" your asset, it will contain
* `url`: the dst with the md5 appended
* `data`: the wrapped content
* `ext`: the file extension of the wrapped asset
* `md5`: the md5 of the wrapped content
* `tag`: the full html tag to render

### Assets
A group of `Asset`s. Use this if you need a single callback to compile multiple
assets or if you want your assets served through middleware.

## Examples
### Use as Middleware with ZappaJS
```
require('zappajs') ->
  wrap = require 'asset-wrap'
  assets = new wrap.Assets [
    new wrap.Snockets {
      src: 'assets/hello.coffee'
      dst: '/js/hello.js'
    }
    new wrap.Stylus {
      src: 'assets/hello.styl'
      dst: '/css/hello.css'
    }
  ], {
    compress: true
    watch: true
  }, (err) =>
    throw err if err
    @use assets.middleware

    @get '/': ->
      @render index: {
        assets: assets
      }

    @view index: ->
      head ->
        text @assets.tag '/css/hello.css'
        text @assets.tag '/js/hello.js'
      body ->
        a href: @assets.url '/css/hello.css', ->
          'View CSS'
        pre ->
          @assets.data '/css/hello.css'
        a href: @assets.url '/js/hello.js', ->
          'View Javascript'
        pre ->
          @assets.data '/js/hello.js'
```

### Generate Asset Dynamically in ZappaJS
```
require('zappajs') ->
  wrap = require 'asset-wrap'

  @get '/': ->
    asset = new wrap.Snockets {
      src: 'assets/hello.coffee'
      compress: true
    }, (err) =>
      @res.send 500, err if err
      @res.setHeader 'ContentType', asset.type
      @res.send asset.data
```

### Generate Asset Dynamically With Cluster
```
cluster = require 'cluster'
os      = require 'os'

if cluster.isMaster
  # Fork workers
  cluster.fork() for i in os.cpus()
  cluster.on 'exit', (worker, code, signal) ->
    console.log "worker #{worker.process.pid} died"
else
  # Workers can share any TCP connection
  require('zappajs') ->
    wrap = require 'asset-wrap'

    @get '/js/hello.js': ->
      asset = new wrap.Snockets {
        src: 'assets/hello.coffee'
        dst: '/js/hello.js'
        compress: true
      }, (err) =>
        @res.send 500, err if err
        @res.setHeader 'ContentType', asset.type
        @res.send asset.data

    @get '/': ->
      @render 'index': {layout: no}

    @view index: ->
      body ->
        div ->
          a href: '/js/hello.js', ->
            'View Javascript'
```

# Credit
Much inspiration from the other asset management tools out there.
* Brad Carleton's [asset-rack](https://github.com/techpines/asset-rack)
* Trevor Burnham's [connect-assets](https://github.com/TrevorBurnham/connect-assets)
* the [Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html)

# License
©2013 Bryant Williams under the [MIT license](http://www.opensource.org/licenses/mit-license.php):

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
