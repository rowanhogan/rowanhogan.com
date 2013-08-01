#= require_directory ./vendor
#= require_tree .

sortTimeline = ->
  $('li', '#timeline').tsort
    data: 'time'
    order: 'desc'

@retrieveItems = (type, url) ->
  $.getJSON url, (data) ->

    if type is "dribble_shot"
      data = data.shots
    else if type is "lastfm_scrobble"
      data = data.recenttracks.track
    else
      data = data.data

    console?.log data
    count = data.length

    $.each data, (i, item) ->
      count--

      unless type is "github_event" and item.type isnt "PushEvent"
        $('#timeline').append JST["templates/#{type}"](item)

      if count is 0
        sortTimeline()
        # $("#timeline").before("<label>#{type}: #{data.length}</label>")

$ ->
  retrieveItems("dribble_shot", "http://api.dribbble.com/players/rowanhogan/shots?callback=?")
  retrieveItems("github_event", "https://api.github.com/users/rowanhogan/events/public?callback=?")
  retrieveItems("lastfm_scrobble", "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=rehogan&api_key=ef147845c58771a584366acb1089d962&format=json&callback=?")

  instagram_access_token = $('#instagram').data('token')
  retrieveItems("instagram", "https://api.instagram.com/v1/users/682546/media/recent/?access_token=#{instagram_access_token}&callback=?")


  # options = valueNames: ["name", "description", "category"]

  # featureList = new List("lovely-things-list", options)
  # $("#filter-games").click ->
  #   featureList.filter (item) ->
  #     if item.values().category is "Game"
  #       true
  #     else
  #       false

  #   false

  # $("#filter-beverages").click ->
  #   featureList.filter (item) ->
  #     if item.values().category is "Beverage"
  #       true
  #     else
  #       false

  #   false

  # $("#filter-none").click ->
  #   featureList.filter()
  #   false



$(document).on 'scroll', (e) ->
  y_pos = $(window).scrollTop()

  if y_pos > 0
    $('body').append('<a href="#" id="top" class="go-to-top">Top</a>') unless $('#top').length
  else
    $('#top').remove()

$(document).on 'click', '#top', (e) ->
  e.preventDefault()
  $(window).scrollTop(0)



