db = require '../models'

module.exports =
  create: (req, res) ->
    db.User.create username: req.params.username, password: req.params.password
    .success (user) ->
      res.send user

  index: (req, res) ->
    db.User.findAll().success (users) ->
      res.send users
