validator = require '../../libs/validator'
Article = require '../../models/article'

module.exports =
  index: (req, res, next)->
    Article.find {}, (err, docs)->
      if err then console.log err
      return res.render 'website/articles/',
        title: 'page'
        articles: docs
