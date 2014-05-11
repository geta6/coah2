'use strict'

console.debug = console.debug || console.log # for IE10

require.config
  baseUrl: '/js/app'

  paths:
    jquery: '../lib/jquery'
    underscore: '../lib/lodash'
    moment: '../lib/moment'
    backbone: '../lib/backbone'
    'backbone.stickit': '../lib/backbone.stickit'
    'backbone.wreqr': '../lib/backbone.wreqr'
    'backbone.babysitter': '../lib/backbone.babysitter'
    'backbone.marionette': '../lib/backbone.marionette'

require [
  'app'
  'main'
], (App) ->
  App.start()
