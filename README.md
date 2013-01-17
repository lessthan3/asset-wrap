Asset-Wrap is a simple asset manager for node.

## Goals
1. build at anytime (server start or on any callback)
2. support stylus, less, and sass to build your css
3. support snockets to build your javascript
4. use async whenever possible
5. support cluster

## Install
```
npm install asset-wrap
```

## Details
### Asset
A wrapped asset, whether using snockets, stylus, sass, or less.

All assets require at a minimum two parameters
* `src`: the path to your source file
* `dst`: the location to serve your file from (with md5 appended). also the cache key

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
### Use as Middleware
```
wrap = require 'asset-wrap'
assets = wrap.AssetWrap [
  new wrap.Stylus {
    src: "#{__dirname}/path/to/app.styl"
    dst: '/css/app.css'
    compress: true
  }
  new wrap.Snockets {
    src: "#{__dirname}/path/to/app.coffee"
    dst: '/js/app.js'
    compress: false
  }
]

assets.on 'complete', () ->
  console.log 'assets compiled'

app.configure () ->
  app.use assets.middleware

@get '/': ->
  @render index: {
    assets: assets
  }

@view index: ->
  head ->
    @assets.tag '/css/app.css'
    @assets.tag '/js/app.js'
```

### Single Asset Dynamically
```
wrap = require '../src/wrap'
asset = new wrap.Snockets {
  src: "#{__dirname}/test.coffee"
  dst: '/js/app.js'
}
asset.on 'complete', () ->
  console.log asset.url
asset.wrap()
```

### Single Asset Dynamically Shortcut
```
asset = new wrap.Snockets {
  src: "#{__dirname}/test.coffee"
  dst: '/js/app.js'
}, (asset) ->
  console.log asset.url
```

### Wrap Single Asset with Zappa
```
@get '/js/app.js': ->
  new wrap.Snockets {
    url: '/js/app.js'
    src: "#{__dirname}/path/to/app.coffee"
  }, (asset) =>
    @response.setHeader 'Content-Type', 'text/javascript'
    @response.write asset.data
```

# Credit
Much inspiration from the other asset management tools out there.
* Brad Carleton's asset-rack
* Trevor Burnham's connect-assets
* the Rails Asset Pipeline
* Mathias Pettersson's connect-assetmanager

# License
©2013 Bryant Williams under the [MIT license](http://www.opensource.org/licenses/mit-license.php):

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
