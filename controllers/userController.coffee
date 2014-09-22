passport = require 'passport'
db = require '../models'


module.exports =
  create: (req, res) ->
    db.User.create username: req.params.username, password: req.params.password
    .success (user) ->
      res.send user

  index: (req, res) ->
    db.User.findAll().success (users) ->
      res.send users

  getLogin: (req, res) ->
    if (req.user) then res.redirect '/'
    res.render 'login', title: 'Login'

  postLogin: (req, res, next) ->
    (passport.authenticate 'local', (err, user, info) ->
      if err then next err
      if not user then res.redirect '/login'
      req.logIn user, (err) ->
        if (err) then next err
        res.render 'index'
    ) req, res, next
