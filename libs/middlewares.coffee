Article = require '../models/article'
Page = require '../models/Page'
async = require 'async'

module.exports =
  findBySlug: (req, res, next, slug)->
    async.waterfall [
      findPageBySlug = (callback) ->
        condition =
          slug: slug
        Page.findOne condition, (err, page)->
          if page
            req.page = page
            callback null, page
          else
            callback null, null
      findArticleBySlug = (page, callback) ->
        if page
          callback null, page
        else
          ## search article by slug
          callback null, null
    ], (err, result) ->
      next()

