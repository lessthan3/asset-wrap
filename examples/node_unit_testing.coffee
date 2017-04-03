stylus = require 'stylus'

s = stylus """

p(0)
p(typeof(0))
p(unit(0, 'px'))

p(var1)
p(typeof(var1))
p(unit(var1, 'px'))

p(var2)
p(typeof(var2))
p(unit(var2, 'px'))

""", {
  filename: 'test.styl'
  paths: []
}
s.define 'var1', new stylus.nodes.Unit 1
s.define 'var2', new stylus.nodes.Unit '2'
s.render (err, result) ->
  console.log result

