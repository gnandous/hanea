mongoose = require 'mongoose'
Schema = mongoose.Schema

Content = new Schema
  creator:
    type: Schema.ObjectId
    ref: 'User'
  type:
    type: String
    required: true
  location:
    type: String
    required: true
  published:
    type: Boolean
    required: true
    default: false
  title:
    type: String
    required: true
  subtitle:
    type: String
    required: true
  content:
    type: String
    required: true

module.exports = Content = mongoose.model 'Content', Content
