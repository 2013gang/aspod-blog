express = require 'express'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'
db = require './models'

port = process.env.PORT || 5000 # set the port

app = do express # create our app w/ express

app.use express.static "#{__dirname}/public" # set the static files location /public/img will be /img for users
app.use bodyParser.urlencoded 'extended':'true' # parse application/x-www-form-urlencoded
app.use do bodyParser.json # parse application/json
app.use bodyParser.json type: 'application/vnd.api+json' # parse application/vnd.api+json as json
app.use methodOverride 'X-HTTP-Method-Override' # override with the X-HTTP-Method-Override header in the request

# routes ======================================================================
(require './app/routes.coffee') app


db.sequelize
.sync force: process.env.DB_SYNC == 'TRUE'
.complete (err) ->
  if err? then throw err[0]
  else
    app.listen port
    console.log "Express server listening on port #{port}"
