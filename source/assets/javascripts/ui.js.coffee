$ ->
  classes = [
    'bigsky'
    'concierge'
    'cricket-scores'
    'karuna'
    'nature-qld'
    'resume-builder'
    'reactive-audio'
    'terrain'
    'wikipadia'
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

  iOS = /iPad|iPhone|iPod/.test(navigator.platform)
  if iOS
    $('iframe').each ->
      $(this).wrap('<div style="display: none; height: 480px; overflow: auto"></div>')

    $('iframe').eq(0).parent().show()
