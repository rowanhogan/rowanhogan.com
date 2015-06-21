#= require jquery/dist/jquery
#= require fastclick/lib/fastclick
#= require moment/moment
#= require tinysort/dist/tinysort
#= require_tree ./templates
#= require_tree .

$ ->
  new FastClick(document.body)
  $('html').removeClass('no-js')
  console?.log "G'Day! :) Please, feel free to take a look around... The source code for this site can be found at https://github.com/rowanhogan/rowanhogan.com"

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
      $('body').addClass context
    ), ->
      $('body').removeClass context


