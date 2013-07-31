#= require tinysort
#= require_tree .

sortTimeline = ->
  $('li', '#timeline').tsort
    data: 'time'
    order: 'desc'

retrieveItems = (type, url) ->
  $.getJSON "#{url}?callback=?", (data) ->
    console?.log data

    if type is "dribble_shot"
      data = data.shots
    else if type is "github_event"
      data = data.data

    count = data.length

    $.each data, (i, item) ->
      count--
      $('#timeline').append JST["templates/#{type}"](item)

      if count is 0
        sortTimeline()

$ ->
  retrieveItems("dribble_shot", "http://api.dribbble.com/players/rowanhogan/shots")
  retrieveItems("github_event", "https://api.github.com/users/rowanhogan/events/public")
