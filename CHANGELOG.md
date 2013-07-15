**v0.3.4** (in progress)

 * add global variables for stylus

**v0.3.3** (2013-06-03 4:59 AM EDT)

  * typo

**v0.3.1** (2013-06-03 4:47 AM EDT)

 * fix merge callback
 * update asset.tag when deploying to cdn

**v0.3.0** (2013-05-31 5:53 PM EDT)

 * add Travis CI
 * separate compiled and complete events
 * add push to cdn
 * push to cdn after compile, but before complete
 * add callback to merge() in case asset needs to go to cdn

**v0.2.3** (2013-04-25 3:03 PM EDT)

 * fix import for chokidar in snockets
 * add snockets test for watch

**v0.2.2** (2013-04-25 2:57 PM EDT)

 * add cleancss option for stylus to concat imported css
 * add file watching for @src file in all modules
 * add file watching for @src and all dependencies in snockets module
 * update stylus to 0.32.1
 * add `define('url', stylus.url())` to stylus module

**v0.2.1** (2013-02-11)

 * ignoreErrors param to wrap.Assets
 * fix merge for javascript files that are missing semicolons
 * add custom Cache-Control setting to middleware
 * add default config values for Assets

**v0.2.0** (2013-01-18 1:00pm EST)

 * Breaking changes to shortcuts
 * Add error handling
 * Update examples
 * Use process.nextTick for shortcut callbacks
 * Use should instead of assert in tests
 * Add examples for express.js

**v0.1.4** (2013-01-17 9:00pm EST)

 * fix stylus nib import
 * add CHANGELOG.md

**v0.1.3** (2013-01-17 7:30pm EST)

 * Fix text/css tags

**v0.1.2** (2013-01-17 6:00pm EST)

 * Add cluster examples
 * Clean up README
 * Add Assets.merge
 * Use src if dst is not defined
 * Add callback shortcut to Assets contructor

**v0.1.1** (2013-01-17 5:00pm EST)

 * Examples
 * Fix express/zappa middleware
 * Sass module
 * Fix Less compress

**v0.1.0** (2013-01-17)

 * Initial Release
 * Stylus module
 * Snockets module
 * Less module
 * Test framework
