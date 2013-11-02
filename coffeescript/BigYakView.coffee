class YakShave.BigYakView extends Marionette.ItemView
  template: '#big_yak-template'
  events: 
    "click .shave": "onShaveClick"
    
  onShaveClick: (e)->
    target = $(e.target)
    if target.hasClass('small')
      $('#yak').addClass('small')
      @shave(6)
    else if target.hasClass('medium')
      $('#yak').addClass('medium')
      @shave(20)
    else if target.hasClass('large')
      $('#yak').addClass('large')
      @shave(120)

  shave: (minutes) ->
    $('#yak').show()
    @totalDuration = minutes*60
    @startTime = new Date()
    @strokeDuration = @totalDuration / 6
    @x = 16
    @dX = 9 
    $('.shave').hide()
    @shaveIt()
    @updateTimer()
    @timerInterval = setInterval @updateTimer, 1000
    @shaveInterval = setInterval @shaveIt, @strokeDuration * 1000

  shaveIt: => 
    razor = $('#razor')
    @x += @dX
    razor.css
      top: '15%'
      right: "#{(@x - 12)/.75}%"
      "-webkit-transition": "top 0s linear, right 0s linear"
    razor.show()
    $('#fur').css('-webkit-transition', "-webkit-mask-position-y 0s linear")
    $('#fur').css('webkit-mask-position', "#{@x}% 100%")
    setTimeout =>
      razor.css
        top: '65%'
        "-webkit-transition": "top #{@strokeDuration}s linear, right #{@strokeDuration}s linear"
      $('#fur').css('-webkit-transition', "-webkit-mask-position-y #{@strokeDuration}s linear")
      $('#fur').css('webkit-mask-position', "#{@x}% 50%")
    , 0
    if @x + @dX >= 79
     clearInterval(@shaveInterval)

  updateTimer: =>
    elapsedSeconds = (new Date() - @startTime) / 1000
    remainingSeconds = @totalDuration - elapsedSeconds
    minutesLeft = Math.floor remainingSeconds/60
    secondsLeft = Math.floor remainingSeconds%60
    zero = if secondsLeft < 10 then "0" else ""
    $('#timer').html "#{minutesLeft}:#{zero}#{secondsLeft} left!"
    if remainingSeconds <= 0
      clearInterval(@timerInterval) 
      $('#timer').html "Done!<br>Now back to work!"
