#= require jquery/dist/jquery
#= require fastclick/lib/fastclick
#= require moment/moment
#= require tinysort/dist/tinysort
#= require_tree .

sortTimeline = ->
  tinysort '#timeline > li',
    data: 'time'
    order: 'desc'

@retrieveItems = (type, url) ->
  $.getJSON url, (data) ->

    if type is "dribbble"
      data = data.shots
    else if type is "lastfm"
      data = data.recenttracks.track
    else
      data = data.data

    if data
      count = data.length

      $.each data, (i, item) ->
        count--

        unless type is "github" and item.type isnt "PushEvent"
          $('#timeline').append JST["templates/#{type}"](item)

        if count is 0
          sortTimeline()
          label = $("<label class='list-label icon-#{type}' data-type='#{type}'></label>")
          $("#timeline-list-labels").append(label)


@initTimeline = ->
  $('#timeline').html('')
  $("#timeline-list-labels").find('.list-label').remove()
  retrieveItems("dribbble", "http://api.dribbble.com/players/rowanhogan/shots?callback=?")
  retrieveItems("github", "https://api.github.com/users/rowanhogan/events/public?callback=?")
  retrieveItems("lastfm", "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=rehogan&api_key=ef147845c58771a584366acb1089d962&format=json&callback=?")
  retrieveItems("instagram", "https://api.instagram.com/v1/users/682546/media/recent/?access_token=#{$('#instagram').data('token')}&callback=?")


$ ->
  new FastClick(document.body)
  $('html').removeClass('no-js')
  console?.log "G'Day! :) Please, feel free to take a look around... The source code for this site can be found at https://github.com/rowanhogan/rowanhogan.com"

  initTimeline() if $('#timeline').length


$(document).off 'click', '#timeline-list-labels label'
$(document).on 'click', '#timeline-list-labels label', (e) ->
  $this = $(this)
  type = $this.data('type')

  $('#timeline-list-labels label').removeClass('active')
  $this.addClass('active')

  if type is "all"
    $(".timeline-list-item").show()
  else
    $(".timeline-list-item").hide()
    $(".timeline-#{type}, .show-all-link").show()
