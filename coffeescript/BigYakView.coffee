YakShave.BigYakView = Marionette.ItemView.extend
  template: '#big_yak-template'
  events: 
    "click #shave": "shave"
  shave: ->
    razor = $('#razor')
    strokeDuration = 15 * 60 / 6
    x = 16
    dX = 9
    shaveIt = ->
      x += dX
      razor.css
        top: '15%'
        right: "#{(x - 12)/.75}%"
        "-webkit-transition": "top 0s linear, right 0s linear"
      razor.show()
      $('#fur').css('-webkit-transition', "-webkit-mask-position-y 0s linear")
      $('#fur').css('webkit-mask-position', "#{x}% 100%")
      setTimeout ->
        razor.css
          top: '65%'
          "-webkit-transition": "top #{strokeDuration}s linear, right #{strokeDuration}s linear"
        $('#fur').css('-webkit-transition', "-webkit-mask-position-y #{strokeDuration}s linear")
        $('#fur').css('webkit-mask-position', "#{x}% 50%")
      , 0
    shaveIt()
    interval = setInterval ->  
      shaveIt()
      if x + dX >= 79
        clearInterval(interval)
    , strokeDuration * 1000