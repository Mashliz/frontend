$ ->
  new Masa()
class Masa
  constructor: (@test) ->
    @btn = $(".btn")
    @text = "testest"
    @init()
  init: () ->
    @cl()
  cl: (b) ->
    @btn.on "click", =>
      alert @text