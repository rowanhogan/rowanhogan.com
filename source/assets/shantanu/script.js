
var fade = function(direction) {
  if (!changingVolume && !localStorage.getItem('mute')) {
    window.changingVolume = true;

    var volume = (direction == 'up' ? 0 : 100);
    audioEngine.setVolume(volume);

    var interval = setInterval(function() {
      if (direction == 'up') {
        volume += 1;
      } else {
        volume -= 1;
      }

      $(document).trigger({type: 'scPlayer:onVolumeChange', volume: volume });
      audioEngine.setVolume(volume);

      if (volume == (direction == 'up' ? 100 : 0)) {
        clearInterval(interval);
        window.changingVolume = false;
      }
    }, 10);
  }
}

var fadeUp = function() {
  if (soundVolume == 0) { fade('up'); }
}

var fadeDown = function() {
  if (soundVolume == 100) { fade('down'); }
}

var changeTrack = function (index) {
  window.changingTrack = true;
  fadeDown();
  setTimeout(function() {
    window.changingTrack = false;
    $('.sc-trackslist li').eq(index).click();
    fadeUp();
  }, 1500);
}

var onScroll = function (tracksArray, lastScrollTop) {
  var $window = $(window),
    scrollTop = $window.scrollTop();

  var htmlArray = [];

  var windowHeight = $window.height(),
    documentHeight = $(document).height();

  $.each(tracksArray, function(i, val) {

    if (!tracksArray[(i + 1)]) {
      // Last track
      var active = val < scrollTop && scrollTop > tracksArray[i - 1];
    } else {
      var active = scrollTop > val && scrollTop < tracksArray[i + 1];
    }

    var activeClass = active ? 'active' : null;
    var topPos = val / (documentHeight - windowHeight) * 100;

    htmlArray.push("<div data-position='" + val + "' class='" + activeClass + "' style='top: " + topPos + "%;'>" + $('.sc-trackslist li').eq(i).find('a').text() + "</div>");

    if (active && !window.changingTrack) {
      if ( !$('.sc-player').hasClass('playing') ) {
        changeTrack(i);
      } else if (!$('.sc-trackslist li').eq(i).hasClass('active')) {
        changeTrack(i);
      }
    }

    lastScrollTop = scrollTop;
  });

  var positionIndicator = $(document).scrollTop() / (documentHeight - windowHeight) * 100;

  htmlArray.push("<span class='current-position-indicator' style='height: " + positionIndicator + "%;'></span>");
  $('#scroll-map').html( htmlArray.join('') );
}


$(function() {

  if (window.soundcloud_url) {

    var $elem = ('<a id="soundcloud-player-elem" href="' + window.soundcloud_url + '"></a>');
    $('body').append($elem);

    $('#soundcloud-player-elem').scPlayer({
      continuePlayback: false,
      loadArtworks: 1,
      apiKey: '8973b01ea261ad37c97efee666ac23c4'
    });

    window.changingVolume = false;
    window.changingTrack = false;

    $('body').append('<div id="mute">Mute</div>');
    $('body').append('<div id="scroll-map" class="loading"></div>');

    $(document).bind('scPlayer:onVolumeChange', function(event) {
      window.soundVolume = event.volume;
    });

    $(document).on('click', '#mute', function(e) {
      if (localStorage.getItem('mute')) {
        audioEngine.setVolume(100);
        $(document).trigger({type: 'scPlayer:onVolumeChange', volume: 100 });
        localStorage.removeItem('mute');
        $(this).removeClass('active');
      } else {
        audioEngine.setVolume(0);
        $(document).trigger({type: 'scPlayer:onVolumeChange', volume: 0 });
        localStorage.setItem('mute', true);
        $(this).addClass('active');
      }
    });

    $(document).bind('onPlayerInit.scPlayer', function(event){
      console.log('ready');

      audioEngine.setVolume(100);
      $(document).trigger({type: 'scPlayer:onVolumeChange', volume: 100 });

      if (localStorage.getItem('mute')) {
        audioEngine.setVolume(0);
        $(document).trigger({type: 'scPlayer:onVolumeChange', volume: 0 });
        $('#mute').addClass('active');
      }

      window.tracksArray = [];
      $('.sqs-block-gallery').each(function() {
        window.tracksArray.push($(this).offset().top);
      });

      var lastScrollTop = 0;

      $(window).on('scroll', function(e) {
        onScroll(tracksArray, lastScrollTop);
      });

      $(window).on('resize', function(e) {
        window.tracksArray = [];
        $('.sqs-block-gallery').each(function() {
          window.tracksArray.push($(this).offset().top);
        });
        onScroll(tracksArray, lastScrollTop);
      });

      onScroll(tracksArray, lastScrollTop);
      $('#scroll-map').removeClass('loading');
    });

    $(document).bind('onMediaTimeUpdate.scPlayer', function(event){
      if ( (event.duration - event.position) < 2000) {
        fadeDown();

        setTimeout(function() {
          audioEngine.seek(0);
          fadeUp();
        }, 1500);
      }
    });

    $(document).on('click', '#scroll-map div', function() {
      $("html, body").animate({ scrollTop: $(this).data('position') + 30 });
    });
  }
});
