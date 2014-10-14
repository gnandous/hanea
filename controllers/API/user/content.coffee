validator = require '../../../libs/validator'
User = require '../../../models/user'
Content = require '../../../models/content'

module.exports =
  create: (req, res, next)->
    console.log "soul"
  read: (req, res, next)->
    console.log ("read")
  update: (req, res, next)->
    console.log ("update")
  delete: (req, res, next)->
    console.log ("delete")
