
sortTimeline = ->
  tinysort '#timeline > li',
    data: 'time'
    order: 'desc'

retrieveItems = (type, url) ->
  $.getJSON url, (data) ->
    data = switch
      when type is "lastfm" then data.recenttracks.track
      else data.data

    if data
      count = data.length

      $.each data, (i, item) ->
        count--

        unless type is "github" and item.type isnt "PushEvent"
          $('#timeline').append JST["templates/#{type}"](item)
          $('#timeline').removeClass('loading')

        sortTimeline() if count is 0

initTimeline = ->
  types = [
    name: "dribbble"
    url: "https://api.dribbble.com/v1/users/rowanhogan/shots?access_token=5f5428831a9e29a663d347e98208de6c1793403210155760730de27280e48a0b&callback=?"
  ,
    name: "github"
    url: "https://api.github.com/users/rowanhogan/events/public?callback=?"
  # ,
  #   name: "lastfm"
  #   url: "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=rehogan&api_key=ef147845c58771a584366acb1089d962&format=json&callback=?"
  ,
    name: "instagram"
    url: "https://api.instagram.com/v1/users/682546/media/recent/?access_token=#{$('#instagram').data('token')}&callback=?"
  ]

  $('#timeline').addClass('loading').html('')
  $("#timeline-list-labels").find('.list-label').remove()

  $.each types, (i, type) ->
    retrieveItems(type.name, type.url)
    label = $("<label class='list-label icon-#{type.name}' data-type='#{type.name}'></label>")
    $("#timeline-list-labels").append(label)

    label.on 'click', (e) ->
      $('#timeline-list-labels label').removeClass('active')
      $(this).addClass('active')
      $('#timeline').addClass('loading').html('')
      retrieveItems(type.name, type.url)

$ ->
  initTimeline() if $('#timeline').length

  $('.show-all-link').on 'click', (e) ->
    $('#timeline-list-labels label').removeClass('active')
    $(this).addClass('active')
    $('#timeline').addClass('loading').html('')
    initTimeline()
