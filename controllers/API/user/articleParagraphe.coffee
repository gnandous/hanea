validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
ArticleParagraphe = require '../../../models/ArticleParagraphe'

module.exports =
  index: (req, res, next)->
    ArticleParagraphe.find()
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    articleParagraphe = new ArticleParagraphe
      article_id : req.body.article_id
      title: req.body.title
      content: req.body.content
    articleParagraphe.save (err, articleParagraphe)->
      if err
        return res.status(400).send(err)
      else
        return res.status(200).send(articleParagraphe)
  show: (req, res, next)->
    conditions =
      _id: req.params.id
    ArticleParagraphe.findOne conditions, (err, articleParagraphe)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(articleParagraphe)

## article is articleParagraphe finded by the query

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    ArticleParagraphe.findOneAndUpdate condition, update, (err, paragraphe)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(paragraphe)
  destroy: (req, res, next)->
    condition =
      _id: req.params.id
    ArticleParagraphe.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      article.remove()
      ArticleParagraphe.find()
      .populate("creator")
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)
