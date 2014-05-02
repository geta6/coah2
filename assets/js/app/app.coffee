define [
  'backbone'
  'backbone.marionette'
], (Backbone) ->

  App = new Backbone.Marionette.Application()

  App.isProduction = ->
    return no

  App.DebugConsoleCalled = 0

  App.addRegions
    MainRegion: '#main'



  class App.DebugConsole

    color: [
      '#2B8694'
      '#8FB320'
      '#CEB124'
      '#76B3CE'
      '#C7A0D4'
      '#C45744'
    ]

    constructor: (label) ->
      unless App.isProduction()
        color = @color[App.DebugConsoleCalled++ % @color.length]
        return ->
          args = Array::slice.call arguments
          args = ["%c#{label}", "color:#{color}"].concat args
          if 0 < (_.filter args, (arg) -> arg instanceof Error).length
            args = _.map args, (arg) ->
              return arg unless arg instanceof Error
              return arg.stack || arg.message
            return console.error.apply console, args
          (console.debug || console.log).apply console, args
      else
        return -> return



  class View extends Backbone.Marionette.ItemView
    debug: new App.DebugConsole 'mainView'
    template: '#template_main'
    onRender: ->
      @debug 'onRender'



  App.addInitializer ->
    App.MainRegion.show new View()


  return App

