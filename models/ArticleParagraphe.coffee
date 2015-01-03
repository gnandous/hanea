mongoose = require 'mongoose'
ArticleItem = require './articleitem'
Schema = mongoose.Schema


ArticleParagrapheSchema = new Schema
  article_id:
    type: Schema.ObjectId
    ref: 'Article'
  title:
    type: String
  content:
    type: String
    required: true

## After create, generate item

ArticleParagrapheSchema.post 'save', (paragraphe)->
  ## create article item
  article_item = new ArticleItem
    article_id: paragraphe.article_id
    item_type: "PARAGRAPHE"
    item_id: paragraphe._id
  article_item.save()


module.exports = ArticleParagraphe = mongoose.model 'ArticleParagraphe', ArticleParagrapheSchema
