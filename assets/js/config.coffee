'use strict'

require.config
  baseUrl: '/js/app'

  paths:
    jquery: '../lib/jquery'
    underscore: '../lib/lodash'
    moment: '../lib/moment'
    backbone: '../lib/backbone'
    'backbone.stickit': '../lib/backbone.stickit'
    'backbone.deepmodel' : '../lib/backbone.deepmodel'
    'backbone.wreqr': '../lib/backbone.wreqr'
    'backbone.babysitter' : '../lib/backbone.babysitter'
    'backbone.marionette': '../lib/backbone.marionette'

console.debug = console.debug || console.log # for IE10

require [ 'app' ], (App) ->
  App.start()

