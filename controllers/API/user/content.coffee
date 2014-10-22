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
    content = new Content
      creator: req.user.id
      type: "section-content"
      location: req.body.location
      published: req.body.published
      title: req.body.title
      subtitle: req.body.subtitle
      content: req.body.content
    content.save (err, content)->
      return res.status(400).send(err) if err
    return res.status(200).send(content)

  read: (req, res, next)->
    Content.find()
    .populate("creator")
    .exec (err, contents)->
      unless contents
        return res.status(400).send(err)
      return res.status(200).send(contents)
  detail: (req, res, next)->
    console.log("detail")
  update: (req, res, next)->
    console.log ("update")
  delete: (req, res, next)->
    console.log ("delete")
