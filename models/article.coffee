ArticleItem = require './articleitem'
Slug = require '../libs/slug'
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
  resum:
    type: String
  content:
    type: String
  slug:
    type: String
  illustration:
    type: String
  categories: [
    type: String
  ]

Article.path('title').required(true, 'Title is required')
Article.path('resum').required(true, 'resum is required')
Article.post 'remove', (doc)->
  ArticleItem.remove
    article_id: doc._id
  , (err)->
    if err then console.log err

module.exports = Article = mongoose.model 'Article', Article
