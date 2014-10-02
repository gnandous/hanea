module.exports =
  switch process.env.NODE_ENV or 'development'
    when 'production'
      console.log("soul")
      url = require('url')
      redisUrl = url.parse(process.env.REDISTOGO_URL)
      redisAuth =  redisUrl.auth.split(':')
      mongo_uri: process.env.MONGOLAB_URI
      redis:
        host: redisUrl.hostname
        port: redisUrl.port
        db: redisAuth[0]
        pass: redisAuth[1]
    when 'development'
      mongo_uri: 'mongodb://localhost/hanea'
      redis:
        host: 'localhost'
        port: '6379'
        db: 1
