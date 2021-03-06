Article = require '../models/article'
ArticleParagraphe = require '../models/ArticleParagraphe'
ArticleMedia = require '../models/Articlemedia'
ArticleItem = require '../models/articleitem'
_ = require 'underscore'
AWS = require './aws'

module.exports =
  PopulateArticleItems: (article_id, callback)->
    condition =
      article_id : article_id
    ArticleItem.find condition, (err, items)->
      populated_items = []
      uids = items.slice()
      (next = ->
        unless uids.length
          return callback null, populated_items
        uid = uids.shift()
        if uid.item_type is "MEDIA"
          uid.populate
            path: 'item_id'
            model: 'ArticleMedia'
          , (err, item)->
            populated_items.push item
            next()
        else if uid.item_type is "PARAGRAPHE"
          uid.populate
            path: 'item_id'
            model: 'ArticleParagraphe'
          , (err, item)->
            populated_items.push item
            next()
      )()
  RemoveApropriateItem: (article_id)->
    str = "https://hanea-assets.s3.amazonaws.com/"
    ArticleMedia.find
      article_id: article_id
    , (err, list)->
      ArticleMedia.remove
        article_id: article_id
      , (err)->
        if err then console.log err

      if err then console.log err
      _.each list, (item, index)->
        if item.content
          distPath = item.content.slice(str.length)
          AWS.destroy distPath, (err, data)->
            if err then console.log err
    ArticleParagraphe.remove
      article_id: article_id
    , (err)->
      if err then console.log err

