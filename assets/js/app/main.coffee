define [
  'app'
  'backbone'
  'backbone.stickit'
  'backbone.marionette'
], (App, Backbone) ->

  App.module 'Main', (exports) ->

    class Model extends Backbone.Model
      defaults:
        title: 'Coah2'
        content: 'Welcome to coah2.'


    class View extends Backbone.Marionette.ItemView
      template: '#template_main'

      ui:
        input: 'input'

      events:
        'keyup @ui.input': 'onKeyupInput'

      bindings:
        'p': 'content'

      onKeyupInput: _.debounce ->
        @model.set 'content', @ui.input.val()
      , 240

      onRender: =>
        @stickit()

      onClose: =>
        @unstickit()


    exports.view = new View
      model: new Model()


  return App
