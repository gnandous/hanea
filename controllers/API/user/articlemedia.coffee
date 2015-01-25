validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
ArticleMedia = require '../../../models/Articlemedia'
AWS = require '../../../libs/aws'
fs = require 'fs'

module.exports =
  index: (req, res, next)->
    ArticleMedia.find()
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    if req.files.file?
      res.send req.files
    else
      distPath = "article-#{req.body.article_id}/#{req.body.medianame}"
      articleMedia = new ArticleMedia
        article_id: req.body.article_id
        content: "/uploads/#{req.body.medianame}"
        #content: "https://hanea-assets.s3.amazonaws.com/#{distPath}"
        title: req.body.title
      articleMedia.save (err, articleMedia)->
        if err
          return res.status(400).send(err)
        else
          fs.readFile req.body.content, (err, data)->
            if err then return res.status(400).send err
            AWS.upload data, distPath, (err, url)->
              if err then return res.status(400).send err
              condition =
                _id: articleMedia._id
              update =
                content: "https://hanea-assets.s3.amazonaws.com/#{distPath}"
              ArticleMedia.findOneAndUpdate condition, update, (err, articleMedia)->
                if err then return res.status(400).send err
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
    ArticleMedia.findOneAndUpdate condition, update, (err, media)->
      if err then return res.status(400).send(err)
      return res.send media


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
