passport = require 'passport'
LocalStrategy = (require 'passport-local').Strategy
db = require '../models'

passport.serializeUser (user, done) ->
  done null, user.username

passport.deserializeUser (username, done) ->
  (db.User.find where: username: username).success (user) ->
    done null, user

passport.use new LocalStrategy(
  (username, password, done) ->
    (db.User.find where: username: username).success (user) ->
      if not user then done null, false, message: 'Incorrect username.'

      if not user.validatePassword password
        done null, false, message: 'Incorrect password.'

      done null, user
)

exports.isAuthenticated = (req, res, next) ->
  if do req.isAuthenticated
    do next
  else
    res.redirect '/login'
