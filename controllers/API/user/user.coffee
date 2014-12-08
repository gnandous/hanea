_ = require 'underscore'
validator = require '../../../libs/validator'
User = require '../../../models/user'

module.exports =
  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    User.findOne condition, (err, user)->
      if err then return res.status(400).send(err)
      else
        user = _.extend(user, update)
        user.save (err, user)->
          if err then return res.status(400).send(err)
          return res.send user



