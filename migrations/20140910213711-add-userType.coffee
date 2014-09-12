module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn 'Users', 'type', DataTypes.STRING
  down: (migration, DataTypes, done) ->
    do done