express = require 'express'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'
passport = require 'passport'
path = require 'path'
swig = require 'swig'
db = require './models'
env = process.env.NODE_ENV || 'development'
port = process.env.PORT || 5000 # set the port

app = do express # create our app w/ express

app.engine 'html', swig.renderFile
app.set 'view engine', 'html'
app.set 'views', (path.join __dirname, 'views')

# set the static files location /public/img will be /img for users
app.use express.static "#{__dirname}/public"
# parse application/x-www-form-urlencoded
app.use bodyParser.urlencoded 'extended':'true'
# parse application/json
app.use do bodyParser.json
# parse application/vnd.api+json as json
app.use bodyParser.json type: 'application/vnd.api+json'
# override with the X-HTTP-Method-Override header in the request
app.use methodOverride 'X-HTTP-Method-Override'

app.use do passport.initialize
app.use do passport.session

# routes ======================================================================
(require './routes.coffee') app

###
switch env
	when 'development'
		db.sequelize
		.sync force: true
		.complete (err) ->
			if err? then throw err[0]
###
app.listen port
console.log "Express server listening on port #{port} in #{env}"
