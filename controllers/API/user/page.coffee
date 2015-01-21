validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
Page = require '../../../models/Page'
AWS = require '../../../libs/aws'
fs = require 'fs'

module.exports =
  index: (req, res, next)->
    Page.find()
    .sort
      date: -1
    .limit(20).exec (err, articleMedias)->
      if err
        next(err)
      return res.status(200).send(articleMedias)

  create: (req, res, next)->
    unless req.body.media
      page = new Page
        title: req.body.title
        content: req.body.content
      page.save (err, page)->
        if err then return res.status(400).send(err)
        return res.status(200).send(page)
    else
      fs.readFile req.body.media, (err, data)->
        if err then return res.status(400).send(err)
        page = new Page
          title: req.body.title
          content: req.body.content
        page.save (err, page)->
          distPath = "page-#{page._id}/#{req.body.medianame}"
          AWS.upload data, distPath, (err, url)->
            if err then return res.status(400).send(err)
          update =
            media: "https://hanea-assets.s3.amazonaws.com/#{distPath}"
          page.media = update.media
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

    update = {}

    if req.body.title?
      update.title = req.body.title
    if req.body.content?
      update.content = req.body.content

    if req.body.to_remove?
      str = "https://hanea-assets.s3.amazonaws.com/"
      distPath = req.body.to_remove.slice(str.length)
      AWS.destroy distPath, (err, data)->
         if err then return res.status(400).send err
      fs.readFile req.body.media, (err, data)->
        if err then return res.status(400).send(err)
        path = "page-#{req.params.id}/#{req.body.medianame}"
        AWS.upload data, path, (err, url) ->
          if err then return res.status(400).send(err)
        update.media = "https://hanea-assets.s3.amazonaws.com/#{path}"
        Page.findOneAndUpdate condition, update, (err, media)->
          if err then return res.status(400).send(err)
          return res.send media
    else
      Page.findOneAndUpdate condition, update, (err, media)->
        if err then return res.status(400).send(err)
        return res.send media

  destroy: (req, res, next)->
    str = "https://hanea-assets.s3.amazonaws.com/"

    condition =
      _id: req.params.id
    Page.findOne condition, (err, article)->
      return res.status(404).send(err) unless article
      if article.media
        distPath = article.media.slice(str.length)
        AWS.destroy distPath, (err, data)->
          if err then return res.status(400).send err
      article.remove()
      Page.find()
      .sort(date:-1)
      .exec (err, articles)->
        unless articles
          return res.status(400).send(err)
        return res.status(200).send(articles)

  file: (req, res, next) ->
    if req.files.file? then return res.status(200).send(req.files.file)
    else
      return res.status(400)

  findBySlug: (req, res, next)->
    if req.page?
      return res.render 'website/pages/page-layout--tpl',
        page: req.page
    else
      next()

