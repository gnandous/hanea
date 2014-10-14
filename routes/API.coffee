express = require('express')
APIRouter = express.Router()
controllers = require '../controllers'
config = require '../config'
jwt = require('express-jwt')

requestInterceptor = (req, res, next)->
  unless req.cookies.hanea_session
    return res.render 'website/404',
      title: config.site.title
  next()
module.exports = () ->
  APIRouter.get '/', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu/add', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/login', controllers.API.user.welcome
  APIRouter.get '/signup', controllers.API.user.signup
  APIRouter.post '/signup', controllers.API.user.register
  APIRouter.post '/login', controllers.API.user.auth
  APIRouter.get '/secure/welcome', controllers.API.user.restricted
  APIRouter.get '/secure/currentuser', controllers.API.user.current.index
  APIRouter.post '/secure/content', controllers.API.user.content.create
  APIRouter.get '*', requestInterceptor
