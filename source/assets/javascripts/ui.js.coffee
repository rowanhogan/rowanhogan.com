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

  $(window).on 'scroll', ->
    document.styleSheets[0].addRule('body:before',"position: absolute");
    document.styleSheets[0].insertRule("body::before { position: absolute; }", 0);
