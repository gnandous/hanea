express = require("express")
path = require("path")
logger = require('morgan')
favicon = require("serve-favicon")
cookieParser = require("cookie-parser")
bodyParser = require("body-parser")
config = require './config'
multer = require 'multer'
app = express()
server = require('http').Server app
env = process.env.NODE_ENV or 'development'
#jwt = require('express-jwt')
expressJwt = require('express-jwt')

require('mongoose').connect config.databases.mongo_uri

# view engine setup
app.set "port", process.env.PORT or 3000
app.set "view engine", "jade"
app.set 'views', "#{__dirname}/views"
# set title
app.set 'title', 'Hanea'
# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
#app.use('/api/secure', expressJwt({secret: config.secret}))
app.use(logger('dev'))
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use multer({dest: "#{__dirname}/client/public/uploads"})
app.use cookieParser()
app.use require('less-middleware')
  src    : "#{__dirname}/client/assets/less"
  dest   : "#{__dirname}/client/public/css"
  prefix : '/css'
app.use require('connect-coffee-script')
  src: "#{__dirname}/client/assets/coffee"
  dest: "#{__dirname}/client/public/js"
  prefix: '/js'
app.use express.static "#{__dirname}/client/public"
#app.use  '/api/*', express.static "#{__dirname}/client/public"
#APIRouter.get '/*', requestInterceptor
#app.use '/api', jwt secret: "shhhhhhared-secret"
require('./routes') app

server.listen app.get("port"), ->
  console.log "Server listening on port #{config.server.port} in #{env} mode"
