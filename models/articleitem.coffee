mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleItemSchema = new Schema
  article_id:
    type: Schema.ObjectId
    ref: 'Article'
  item_type:
    type: String
    required: true
  item_id:
    type: Schema.ObjectId
    required: true

module.exports = ArticleItem = mongoose.model 'ArticleItem', ArticleItemSchema
