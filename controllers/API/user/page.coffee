validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
Page = require '../../../models/Page'

module.exports =
  index: (req, res, next)->
    Page.find()
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    page = new Page
      title: req.body.title
      content: req.body.content
    page.save (err, page)->
      if err then return res.status(400).send(err)
      return res.status(200).send(page)


  show: (req, res, next)->
    conditions =
      _id: req.params.id
    Page.findOne conditions, (err, page)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(page)

## article is page finded by the query

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    Page.findOneAndUpdate condition, update, (err, media)->
      if err then return res.status(400).send(err)
      return res.send media


  destroy: (req, res, next)->
    condition =
      _id: req.params.id
    Page.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      article.remove()
      Page.find()
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)
