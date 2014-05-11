define [
  'backbone'
  'backbone.marionette'
], (Backbone) ->

  App = new Backbone.Marionette.Application()

  App.addRegions
    MainRegion: '#main'

  App.addInitializer ->
    App.MainRegion.show App.Main.view

  return App

