#= require_directory ./vendor
#= require_tree .

sortTimeline = ->
  $('li', '#timeline').tsort
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

    count = data.length

    # window[type] = data

    $.each data, (i, item) ->
      count--

      unless type is "github" and item.type isnt "PushEvent"
        $('#timeline').append JST["templates/#{type}"](item)

      if count is 0
        sortTimeline()
        $("#timeline-list-labels").append("<label class='list-label icon-#{type}' data-type='#{type}'></label>")


@initTimeline = ->
  $('#timeline').html('')
  $("#timeline-list-labels").find('.list-label').remove()
  retrieveItems("dribbble", "http://api.dribbble.com/players/rowanhogan/shots?callback=?")
  retrieveItems("github", "https://api.github.com/users/rowanhogan/events/public?callback=?")
  retrieveItems("lastfm", "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=rehogan&api_key=ef147845c58771a584366acb1089d962&format=json&callback=?")
  retrieveItems("instagram", "https://api.instagram.com/v1/users/682546/media/recent/?access_token=#{$('#instagram').data('token')}&callback=?")

$ ->
  new FastClick(document.body)
  console?.log "G'Day! :) Please, feel free to take a look around..."
  $('html').removeClass('no-js')

  initTimeline()


$(document).on 'scroll', (e) ->
  y_pos = $(window).scrollTop()

  if y_pos > $('.header').outerHeight()
    $("#timeline-list-labels").addClass('fixed')
    $('body').append('<a href="#" id="top" class="go-to-top">Top</a>') unless $('#top').length
  else
    $("#timeline-list-labels").removeClass('fixed')
    $('#top').remove()

$(document).on 'click', '#top', (e) ->
  e.preventDefault()
  $(window).scrollTop(0)


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
