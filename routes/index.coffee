config = require ('../config')
User = require '../models/user'

loadUserFromEmail = ()->
  (req, res, next)->
    unless req.cookies.hanea_session
      return res.status(401).send('Require autorisation')
    User.findOne
      _id: req.cookies.hanea_session
    , (err, user)->
      if user
        req.user =
          name: user.name
          email: user.email
          id: user._id
          token: user.token
        next()
      else
        return res.status(401).send(err)

module.exports = (app) ->
  app.use '/api/secure/', loadUserFromEmail()
  app.use '/api', require('./API')()
  app.use '/', require('./website')()
