$ ->
#   new Test("changed")
# class Test
#   constructor:(txt) ->
#     @txt = txt
#     @init()
#   init:->
#     @changeTxt()
#   changeTxt: ->
#     $(".test").on "click", (e) =>
#       console.log e
#       $(e.target).text("test");
  