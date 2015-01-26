validator = require '../../../libs/validator'
User = require '../../../models/user'
DbHelpers = require '../../../libs/dbhelpers'
_ = require 'underscore'
Article = require '../../../models/article'
AWS = require '../../../libs/aws'
fs = require 'fs'

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
      resum: req.body.resum
      content: req.body.content
      illustration: "uploads/#{req.body.illustrationname}"
      categories: req.body.categories
    article.save (err, article)->
      if err
        return res.status(400).send(err)
      else
        if req.body.illustrationname?
          distPath = "article-#{article._id}/#{req.body.illustrationname}"
          fs.readFile req.body.illustration, (err, data)->
            if err then return res.status(400).send err
            AWS.upload data, distPath, (err, url)->
              if err then return res.status(400).send err
              condition =
                _id: article._id
              update =
                illustration: "https://hanea-assets.s3.amazonaws.com/#{distPath}"
              Article.findOneAndUpdate condition, update, (err, updatearticle)->
                if err then return res.status(400).send err
        return res.send article

  show: (req, res, next)->
    conditions =
      _id: req.params.id
    Article.findOne conditions, (err, article)->
      if article
        DbHelpers.PopulateArticleItems req.params.id, (err, populated_items)->
          unless err
            article.set "items", populated_items,
              strict: false
            return res.status(200).send(article)
          return res.status(400).send(err)
      else
        return res.status(400).send(err)

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
    str = "https://hanea-assets.s3.amazonaws.com/"
    condition =
      _id: req.params.id
    Article.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      DbHelpers.RemoveApropriateItem req.params.id
      if article.illustration
        distPath = article.illustration.slice(str.length)
        AWS.destroy distPath, (err, data)->
          if err then console.log err
      article.remove()
      Article.find()
      .populate("creator")
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)

  file: (req, res, next)->
    #must send to amazon s3 depending on host solution
    return res.status(200).send(req.files.file)

