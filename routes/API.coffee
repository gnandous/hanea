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
badRequest = (req, res, next)->
  return res.render 'website/404',
    title: config.site.title
  next()
module.exports = () ->
  APIRouter.get '/', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu/add', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu/all', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/contenu/edit/:id', requestInterceptor, controllers.API.user.welcome

  APIRouter.get '/staff/edit/:id', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/staff/add', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/staffs', requestInterceptor, controllers.API.user.welcome


  #login signup logout
  APIRouter.get '/login', controllers.API.user.welcome
  APIRouter.get '/signup', controllers.API.user.signup
  APIRouter.post '/signup', controllers.API.user.register
  APIRouter.post '/login', controllers.API.user.auth

  #articles
  APIRouter.get '/article/add', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/articles', requestInterceptor, controllers.API.user.welcome
  APIRouter.get '/article/update/:id', requestInterceptor, controllers.API.user.welcome
  #articles

  APIRouter.get '/user/:id/edit', requestInterceptor, controllers.API.user.welcome



  #API call with ajax
  APIRouter.get '/secure/welcome', controllers.API.user.restricted
  APIRouter.get '/secure/sign_s3', controllers.API.user.staff.mys3
  APIRouter.get '/secure/currentuser', controllers.API.user.current.index
  APIRouter.get '/secure/content/all', controllers.API.user.content.read
  APIRouter.post '/secure/content', controllers.API.user.content.create
  APIRouter.post '/secure/staff', controllers.API.user.staff.create
  APIRouter.get '/secure/staffs', controllers.API.user.staff.index
  APIRouter.get '/secure/staff/show/:id', controllers.API.user.staff.show
  APIRouter.post '/secure/staff/update/:id', controllers.API.user.staff.update
  APIRouter.post '/secure/content/update/:id', controllers.API.user.content.update
  APIRouter.get '/secure/content/remove/:id', controllers.API.user.content.delete
  APIRouter.get '/secure/content/detail/:id', controllers.API.user.content.detail

  #handle articles request
  APIRouter.get '/secure/articles', controllers.API.user.article.index
  APIRouter.get '/secure/article/:id', controllers.API.user.article.show
  APIRouter.get '/secure/article/remove/:id', controllers.API.user.article.destroy
  APIRouter.post '/secure/article', controllers.API.user.article.create
  APIRouter.post '/secure/article/file/post', controllers.API.user.article.file
  APIRouter.post '/secure/article/update/:id', controllers.API.user.article.update


  #handle users request
  APIRouter.post '/secure/user/:id/update', controllers.API.user.user.update

  #handle article paragraphe / media
  APIRouter.post '/secure/article/:id/paragraphe', controllers.API.user.articleParagraphe.create
  APIRouter.post '/secure/paragraphe/:id', controllers.API.user.articleParagraphe.update
  APIRouter.post '/secure/media/:id', controllers.API.user.articleMedia.update
  APIRouter.post '/secure/article/:id/media', controllers.API.user.articleMedia.create
  APIRouter.get '/secure/paragraphe/:id', controllers.API.user.articleParagraphe.show
  APIRouter.get '/secure/media/:id', controllers.API.user.articleMedia.show

  #APIRouter.get '/secure/', controllers.API.user.article.index


  APIRouter.get '/*', controllers.API.user.welcome
  #APIRouter.get '/*', badRequest
  return APIRouter
