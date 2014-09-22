fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'
env = process.env.NODE_ENV || 'development'

createSequelizeInstance = (env) ->
	switch env
		when 'development'
			dbConfig = (require '../config/config.json').development

			sequelize = new Sequelize dbConfig.database, dbConfig.username, dbConfig.password,
				dialect: dbConfig.dialect,
				port: dbConfig.port

		when 'production'
			if process.env.DATABASE_URL
				match = process.env.DATABASE_URL.match /postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/
				sequelize = new Sequelize match[5], match[1], match[2],
					dialect: 'postgres',
					protocal: 'postgres',
					port: match[4],
					host: match[3]

sequelize = createSequelizeInstance env

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

module.exports = _.extend sequelize: sequelize, Sequelize: Sequelize, db
