validator = require '../../../libs/validator'
User = require '../../../models/user'
Content = require '../../../models/content'

module.exports =
  create: (req, res, next)->
    errors = []
    unless req.body.location
      errors.push
        field: 'location'
        error: 'Location must be filled'
    unless req.body.title
      errors.push
        field: 'title'
        error: 'Tilte must be filled'
    unless req.body.subtitle
      errors.push
        field: 'subtitle'
        error: 'Subtitle must be filled'
    unless req.body.content
      errors.push
        field: 'content'
        error: 'Content must be filled'
    unless req.body.published
      errors.push
        field: 'published'
        error: 'Published must be filled'
    return res.status(400).send(errors) if errors.length

  read: (req, res, next)->
    console.log ("read")
  update: (req, res, next)->
    console.log ("update")
  delete: (req, res, next)->
    console.log ("delete")
