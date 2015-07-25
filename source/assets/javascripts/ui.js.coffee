colorInRange = (min, max) ->
  Math.floor(Math.random()*(max-min+1)+min)

changeColor = ->
  color = "hsl(#{colorInRange(0, 359)}, 100%, 85%)"

  document.styleSheets[0].addRule('body:before',"border-color: #{color}");
  document.styleSheets[0].insertRule("body::before { border-color: #{color}; }", 0);

$ ->
  classes = [
    'bigsky'
    'terrain'
    'rhokbrisbane'
    'trigger'
    'scout'
    'ausbuild'
    'cricket-scores'
    'nature-qld'
    'karuna'
    'dribbble'
    'linkedin'
    'twitter'
    'lastfm'
    'github'
  ]

  $.each classes, (i, context) ->
    $(".#{context}").hover (->
      $('html').addClass context
    ), ->
      $('html').removeClass context

  $('a:link').click (e) ->
    $('body').addClass('leaving')

  if $('body').hasClass('index')
    setTimeout (->
      changeColor()

      setInterval (->
        changeColor()
      ), 3000
    ), 3000

  $(window).on 'scroll', ->
    document.styleSheets[0].addRule('body:before',"position: absolute");
    document.styleSheets[0].insertRule("body::before { position: absolute; }", 0);


