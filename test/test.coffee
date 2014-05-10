# Dependencies

fs = require 'fs'
path = require 'path'
assert = require 'assert'
request = require 'supertest'

process.env.NODE_ENV = 'test'

if fs.existsSync env = path.resolve 'config', 'env.json'
  process.env[k] = v for k, v of require env

app = require path.resolve 'config', 'app'

describe 'app', ->

  before (done) ->
    app.listen done

  it 'returns 200', (done) ->
    request(app).get('/').expect(200).end(done)

