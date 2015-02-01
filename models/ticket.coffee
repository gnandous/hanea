mongoose = require 'mongoose'
Schema = mongoose.Schema
crypto = require('crypto')
mailer = require '../libs/emailer'
config = require("../config")

# Mongoose schema
Ticket = new Schema
  creator:
    type: Schema.ObjectId
    ref: 'User'
    required: true
  subject:
    type: String
    required: true
  token:
    type: String
    required: true
  content:
    type: String
    required: true
  status:
    type: String
    enum: ["Pending", "In progress", "Done"]
    required: true


module.exports = Ticket = mongoose.model 'Ticket', Ticket
