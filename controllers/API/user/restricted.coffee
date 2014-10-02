config = require '../../../config'
jwt = require 'jsonwebtoken'

module.exports = (req, res, next)->
  return res.status(200).send("Hello #{req.user.name} you are logged")

