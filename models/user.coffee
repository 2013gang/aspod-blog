whiteList = ['norman.xin@turn.com']

module.exports = (sequelize, DataTypes) ->
  User = sequelize.define 'User',
    username:
      type: DataTypes.STRING,
      primaryKey: yes,
      validate:
        isEmail: yes,
        isIn: [whiteList]

    password: DataTypes.STRING
