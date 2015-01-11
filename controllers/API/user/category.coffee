validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
Category = require '../../../models/Category'

module.exports =
  index: (req, res, next)->
    Category.find()
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    category = new category req.body
    category.save (err, category)->
      if err then return res.status(400).send(err)
      return res.status(200).send(category)


  show: (req, res, next)->
    conditions =
      _id: req.params.id
    Category.findOne conditions, (err, category)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(category)

## article is category finded by the query

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    Category.findOneAndUpdate condition, update, (err, media)->
      if err then return res.status(400).send(err)
      return res.send media


  destroy: (req, res, next)->
    condition =
      _id: req.params.id
    Category.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      article.remove()
      Category.find()
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)
