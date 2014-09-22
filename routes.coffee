userController = require './controllers/userController'

module.exports = (app) ->
	app.get '/db/user/:username/:password', userController.create

	app.get '/db/users', userController.index

	app.get '*', (req, res) ->
		res.sendfile './public/index.html'
