db = require '../models'

module.exports = (app) ->

	app.get '/db/user/:nm/:pwd', (req, res) ->
		db.User.create username: req.params.nm,password: req.params.pwd  
		.success (user) -> res.send user

	app.get '/db/users', (req, res) ->
		db.User.findAll().success (users) -> res.send users

	app.get '*', (req, res) ->
		res.sendfile './public/index.html'