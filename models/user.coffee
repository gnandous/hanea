mongoose = require 'mongoose'
Schema = mongoose.Schema
crypto = require('crypto')
mailer = require '../libs/emailer'
config = require("../config")
bcrypt = require 'bcrypt'

# Mongoose schema
User = new Schema
  name:
    type: String
    required: true
  email:
    type: String
    require: true
  password:
    type: String
    require: true
  token:
    type: String
  avatar:
    type: String
    defautl: 'avatar2'

# Mongoose methods
User.statics.generateToken = ->
  crypto.randomBytes(16).toString('hex')
User.statics.ifexist = (data, callback)->
  @findOne
    email: data.email
  ,(err, user)->
    callback err, user

User.methods.comparePassword = (candidatePassword, callback) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    if err then callback err, null else callback null, isMatch

module.exports = User = mongoose.model 'User', User
