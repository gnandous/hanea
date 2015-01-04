Article = require '../models/article'
ArticleItem = require '../models/articleitem'

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
        uid = uids.pop()
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
