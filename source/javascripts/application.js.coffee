#= require jquery

@waves = ->
  $("#waves").addClass("anim").delay(4000).queue ->
    $(this).removeClass "anim"
    $(this).dequeue()

@offsetImages = ->
  $('li img').each ->
    $this = $(this)
    width = $this.outerWidth()
    pWidth = $this.parent().outerWidth()

    if (width > pWidth)
      imgOffset = (width - pWidth) / 2
      $this.css
        'margin-left': '-' + imgOffset + 'px'


@iterateImages = ->
  angles = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360]
  timeFrame = 80000
  interval = timeFrame / angles.length - 1;

  i = 0

  (iterate = ->
    if angles.length > i
      rotationAmount = angles[i]
      current = $('.slider').find('.current')

      $('.slider li').removeClass()
      current.addClass('afterCurrent')
      current.prev().addClass('current')
      current.prev().prev().addClass('beforeCurrent')

      if i == angles.length - 3
        $('.slider li:last').addClass('beforeCurrent')

      if i == angles.length - 2
        $('.slider li:last').addClass('current')
        $('.slider li').eq(angles.length - 2).addClass('beforeCurrent')

      $('.slider ul').css
        '-webkit-transform': 'rotate(' + rotationAmount + 'deg)'
      i++

    setTimeout iterate, interval
  )()


$ ->

  # window.setTimeout (->
  #   waves()
  # ), 1250

  # window.setInterval (->
  #   waves()
  # ), 7500

  $('a').live 'touchstart', ->
    $(this).addClass('active')

  $('a').live 'touchend', ->
    $(this).removeClass('active')

  $('a').live 'touchmove', ->
    $(this).removeClass('active')

  iterateImages()

  window.setInterval (->
    iterateImages()
  ), 80000
