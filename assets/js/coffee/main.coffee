(($)->
  $ ->
    new Js()
) jQuery

cl = (o) -> console.log o 

class Js
  constructor: (@test) ->
    @btn = $(".btn")
    @text = "testest"
    @init()
  init: () ->
    @cl()
  cl: (b) ->
    @btn.on "click", =>
      alert @text
