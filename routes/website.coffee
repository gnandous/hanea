express = require 'express'
websiteRouter = express.Router()
controllers = require '../controllers'
config = require '../config'
middlewares = require '../libs/middlewares'


module.exports = () ->
  ## params handling

  websiteRouter.param 'slug', middlewares.findBySlug

  websiteRouter.get '/:slug', controllers.API.user.page.findBySlug
  websiteRouter.get '/page', (req, res, next)->
    return res.render 'website/pages/page-layout--tpl',
      title: 'page'
  ## article slug // websiteRouter.get '/:slug', controllers.API.user.article.findBySlug

  ## home page handling
  websiteRouter.get '/', (req, res, next)->
    return res.render 'website/home/home',
      title: 'Hello'
  websiteRouter.get '/articles', controllers.website.article.index
  return websiteRouter
