config = require '../../../config'
User = require '../../../models/user'

module.exports =
  index: (req, res, next) ->
    unless req.user
      return res.status(400).send("Unknown user")
    User.findOne
      email: req.user.email
    , (err, user)->
      unless user
        return res.status(401).send(err)
      return res.status(200).send(user)
