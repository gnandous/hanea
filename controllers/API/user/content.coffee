validator = require '../../../libs/validator'
User = require '../../../models/user'
config = require '../../../config/'
bcrypt = require 'bcrypt'

module.exports =
  create: (req, res, next)->
    console.log "soul"
  read: (req, res, next)->
    console.log ("read")
  update: (req, res, next)->
    console.log ("update")
  delete: (req, res, next)->
    console.log ("delete")
