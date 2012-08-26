#= require jquery

@waves = ->
  $("#waves").addClass("anim").delay(4000).queue ->
    $(this).removeClass "anim"
    $(this).dequeue()

$ ->
  window.setTimeout (->
    waves()
  ), 1250

  window.setInterval (->
    waves()
  ), 5500
