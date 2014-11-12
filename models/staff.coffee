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
  lastname:
    type: String
  bio:
    type: String
  role:
    type: String
  avatar:
    type: String

Staff.path('name').required(true, 'Name can not be blank')
Staff.path('lastname').required(true, 'Lastname can not be blank')
Staff.path('bio').required(true, 'Bio can not be blank')
Staff.path('role').required(true, 'Role can not be blank')
Staff.path('avatar').required(true, 'Avatar can not be blank')
module.exports = Staff = mongoose.model 'Staff', Staff
