mongoose = require 'mongoose'
Schema = mongoose.Schema

Activity = new Schema
  published:
    type: Date
  actor:
    type: Schema.ObjectId
    ref: 'User'
  verb:
    type: String
    required: true
  target:
    type: Schema.ObjectId

module.exports = Activity = mongoose.model 'Activity', Activity
