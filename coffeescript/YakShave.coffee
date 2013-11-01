window.YakShave = new Backbone.Marionette.Application()

YakShave.addRegions
  main: '#content'

YakShave.on 'initalize:after', ->
  Backbone.history.start()

YakShave.addInitializer ->
  bigYakView = new YakShave.BigYakView
    model: new Backbone.Model
      image_path: "images/yak.png"

  YakShave.main.show(bigYakView)

$(document).ready ->
  YakShave.start()