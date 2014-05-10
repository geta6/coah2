passport = require 'passport'
{Strategy} = require 'passport-local'

module.exports = (app) ->

  {User} = app.get 'models'

  passport.serializeUser (user, callback) ->
    # done null, user._id
    callback null, user

  passport.deserializeUser (user, callback) ->
    # User.findById
    callback null, user

  passport.use new Strategy (user, pass, callback) ->
    process.nextTick ->
      callback new Error 'require implementation'

  app.all '/session', (req, res) ->
    if req.isAuthenticated()
      req.logout()
      return res.redirect '/'
    passport.authenticate 'local',
      failureRedirect: '/'
      successRedirect: '/'
    .apply this, arguments

