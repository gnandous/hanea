mongoose = require 'mongoose'
Schema = mongoose.Schema

Article = new Schema
  date:
    type: Date
    default: Date.now
  creator:
    type: Schema.ObjectId
    ref: 'User'
    required: true
  published:
    type: Boolean
    default: false
  title:
    type: String
  content:
    type: String

Article.path('title').required(true, 'Title is required')
module.exports = Article = mongoose.model 'Article', Article
