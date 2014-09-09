db = require '../models'

module.exports = (app) ->

	app.get '/db/users', (req, res) ->
		db.User.findAll().success (users) -> res.send users

	app.get '*', (req, res) ->
		res.sendfile './public/index.html'