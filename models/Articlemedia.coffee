mongoose = require 'mongoose'
ArticleItem = require './articleitem'
Schema = mongoose.Schema

ArticleMediaSchema = new Schema
  article_id:
    type: String
    required: true
  title:
    type: String
  content:
    type: String
    required: true

## After create, generate item

ArticleMediaSchema.pre 'save', (next)->
  ##TODO Send to amazone s3 and next
  next()

ArticleMediaSchema.post 'save', (media)->
  ## create article item
  article_item = new ArticleItem
    article_id: media.article_id
    item_type: "MEDIA"
    item_id: media._id
  article_item.save()


module.exports = ArticleMedia = mongoose.model 'ArticleMedia', ArticleMediaSchema
