mongoose = require 'mongoose'
Schema = mongoose.Schema
ArticleItem = require './articleitem'

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
  illustration:
    type: String

Article.path('title').required(true, 'Title is required')

Article.post 'remove', (doc)->
  ArticleItem.remove
    article_id: doc._id
  , (err)->
    if err then console.log err

module.exports = Article = mongoose.model 'Article', Article
