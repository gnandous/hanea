config = require '../../../config'
User = require '../../../models/user'

module.exports =
  index: (req, res, next) ->
    User.findOne
      email: req.user.email
    , (err, user)->
      unless user
        return res.status(401).send(err)
      return res.status(200).send(user)
