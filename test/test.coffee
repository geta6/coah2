# Dependencies

fs = require 'fs'
path = require 'path'
assert = require 'assert'

# Environment

process.env.NODE_ENV = 'test'

# Local Dependencies

app = require path.resolve 'config', 'app'
request = require 'supertest'

describe 'app', ->

  before (done) ->
    app.listen done

  # after (done) ->
  #   app.close done

  it 'returns 200', (done) ->
    request(app).get('/').expect(200).end(done)

