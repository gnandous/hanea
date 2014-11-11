mongoose = require 'mongoose'
Schema = mongoose.Schema
crypto = require('crypto')
mailer = require '../libs/emailer'
config = require("../config")
bcrypt = require 'bcrypt'

# Mongoose schema
Staff = new Schema
  name:
    type: String
    required: true
  lastname:
    type: String
    require: true
  email:
    type: String
    default: null
    unique: true
  avatar:
    type: String
    defautlt: 'avatar2'

module.exports = Staff = mongoose.model 'Staff', Staff
