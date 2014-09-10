fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'

if process.env.DATABASE_URL
	 match = process.env.DATABASE_URL.match /postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/
	 console.log match
	 sequelize = new Sequelize match[5], match[1], match[2], 
	 dialect: 'postgres',
	 protocal: 'postgres',
	 port: match[4],
	 host: match[3]

	else sequelize = new Sequelize 'mylocaldb', 'gli', null,
  dialect: 'postgres',
  port: 5432

_ = require 'lodash'
db = {}

fs.readdirSync __dirname
.filter (file) ->
  ((file.indexOf '.') isnt 0) and (file isnt 'index.coffee')
.forEach (file) ->
  model = sequelize.import path.join __dirname, file
  db[model.name] = model

for modelName in Object.keys db
  db[modelName].associate db if 'associate' in db[modelName]

module.exports = _.extend
  sequelize: sequelize,
  Sequelize: Sequelize
, db
