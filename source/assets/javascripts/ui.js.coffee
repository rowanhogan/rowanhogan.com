colorInRange = (min, max) ->
  Math.floor(Math.random()*(max-min+1)+min)

changeColor = ->
  color = "hsl(#{colorInRange(0, 359)}, 100%, 85%)"

  document.styleSheets[0].addRule('body:before',"border-left-color: #{color}");
  document.styleSheets[0].insertRule("body::before { border-left-color: #{color}; }", 0);

  document.styleSheets[0].addRule('body:before',"border-top-color: #{color}");
  document.styleSheets[0].insertRule("body::before { border-top-color: #{color}; }", 0);

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
    ), 5000
