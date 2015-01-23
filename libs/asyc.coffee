Article = require '../models/article'
Page = require '../models/Page'

module.exports =
  findPageBySlug: (callback)->
    callback null, "soul", "ide"
  findArticleBySlug: (page, callback)->
    callback null, 'ok'
