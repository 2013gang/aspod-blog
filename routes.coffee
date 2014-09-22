userController = require './controllers/userController'
homeController = require './controllers/homeController'
passportConf = require './config/passport'

module.exports = (app) ->
	app.get '/', passportConf.isAuthenticated, homeController.index
	app.get '/login', userController.getLogin
	app.post '/login', userController.postLogin
	app.get '/db/user/:username/:password', userController.create
	app.get '/db/users', userController.index
