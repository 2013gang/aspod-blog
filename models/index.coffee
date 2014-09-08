fs = require 'fs'
path = require 'path'
Sequelize = require 'sequelize'
sequelize = new Sequelize 'aspod-blog-db', 'nxin', null,
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
