#= require jquery

getMainHeight = ->
  mainHeight = $(window).outerHeight() - $('#header').outerHeight() - $('#nav').outerHeight() - $('#footer').outerHeight() + 30
  $('#main').css
    'height': mainHeight

date = new Date()
today = date.getDate()
todayDate = today + ""


$ ->
  getMainHeight()

  $('nav a').click (e) ->
    $(this).parent().find('a').removeClass 'active'
    $(this).addClass 'active'
    e.preventDefault()

  $('.icon-envelope').click ->
    $('#position-indicator').css
      'left':'140px'
    $('#about').css
      'left':'-100%'
      'opacity':'0'
    $('#contact').css
      'left':'0'
      'opacity':'1'

  $('.icon-copy').click ->
    $('#position-indicator').css
      'left':'47px'
    $('#about').css
      'left':'0'
      'opacity':'1'
    $('#contact').css
      'left':'100%'
      'opacity':'0'

  $(window).resize ->
    getMainHeight()
