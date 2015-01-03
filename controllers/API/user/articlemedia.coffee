validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
ArticleMedia = require '../../../models/Articlemedia'

module.exports =
  index: (req, res, next)->
    ArticleMedia.find()
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    if req.files.file?
      ##TODO handle file transfert
      res.send req.files.file.name
    else
      articleMedia = new ArticleMedia
        article_id: req.body.article_id
        content: req.body.content
        title: req.body.title
      articleMedia.save (err, articleMedia)->
        if err
          return res.status(400).send(err)
        else
          return res.send(articleMedia)

  show: (req, res, next)->
    conditions =
      _id: req.params.id
    ArticleMedia.findOne conditions, (err, articleMedia)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(articleMedia)

## article is articleMedia finded by the query

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    ArticleMedia.findOne condition, (err, article)->
      if err
        return res.status(400).send(err)
      article = _.extend article, update
      article.save (err, article)->
        if err
          return res.status(400).send(err)
        return res.status(200).send(article)

  destroy: (req, res, next)->
    condition =
      _id: req.params.id
    ArticleMedia.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      article.remove()
      ArticleMedia.find()
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)
