(($)->
  $ ->
    new Js()
) jQuery

cl = (o) -> console.log o 

class Js
  constructor: () ->
    @btn = $(".btn")
    @init()
  init: () ->
    @test()
  test: () ->
    @btn.on "click", ->
      alert("worked")1
      alert 1