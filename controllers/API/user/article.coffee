validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
Article = require '../../../models/article'

module.exports =
  index: (req, res, next)->
    Article.find()
    .populate("creator")
    .limit(20).exec (err, articles)->
      if err
        next(err)
      return res.status(200).send(articles)

  create: (req, res, next)->
    article = new Article
      creator: req.user.id
      title: req.body.title
      content: req.body.content
    article.save (err, article)->
      if err
        return res.status(400).send(err)
      else
        return res.status(200).send(article)
  show: (req, res, next)->
    conditions =
      _id: req.params.id
    Article.findOne conditions, (err, article)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(article)



  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    Article.findOne condition, (err, article)->
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
    Article.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      article.remove()
      Article.find()
      .populate("creator")
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)

