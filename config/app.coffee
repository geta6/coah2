'use strict'

path = require 'path'
http = require 'http'
express = require 'express'

pkg = require path.resolve 'package.json'
app = module.exports = express()

app.use (require 'static-favicon')()
app.use express.static path.resolve 'public'
if 'test' isnt process.env.NODE_ENV
  app.use (require 'morgan')('dev')
app.use (require 'connect-stream')('.')

if 'development' is process.env.NODE_ENV
  app.get /^\/assets\/.*?/, (req, res) ->
    res.stream req.url

app.use (req, res, next) ->
  res.status 404
  res.end 'not found'

