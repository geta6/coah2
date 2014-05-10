process.env.NODE_ENV = 'test'

fs = require 'fs'
path = require 'path'
assert = require 'assert'
request = require 'supertest'

envs = [
  (path.resolve 'config', 'env.json')
  (path.resolve 'config', 'env.json.sample')
]

for env in envs when fs.existsSync env
  env = JSON.parse fs.readFileSync env, 'utf-8'
  process.env[k] = v for k, v of env
  break

app = require path.resolve 'config', 'app'

describe 'app', ->

  before (done) ->
    app.listen done

  it 'returns 200', (done) ->
    request(app).get('/').expect(200).end(done)

