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

  delete: (req, res, next)->
    Content.findOne
      _id: req.params.id
    ,(err, content)->
      return res.status(404).send(err) unless content
      content.remove()
      Content.find()
      .populate("creator")
      .sort(date:-1)
      .exec (err, contents)->
        unless contents
          return res.status(400).send(err)
        return res.status(200).send(contents)

  read: (req, res, next)->
    Content.find()
    .populate("creator")
    .sort(date: -1)
    .exec (err, contents)->
      unless contents
        return res.status(400).send(err)
      return res.status(200).send(contents)

  detail: (req, res, next)->
    if req.params.id?
      Content.findOne
        _id: req.params.id
      ,(err, content)->
        return res.status(404).send(err) unless content
        return res.status(200).send(content)

  update: (req, res, next)->
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
    return res.status(400).send(errors) if errors.length

    condition =
      _id: req.params.id

    update = {}
    if req.body.location?
      update.location = req.body.location
    if req.body.title?
      update.title = req.body.title
    if req.body.subtitle?
      update.subtitle = req.body.subtitle
    Content.findOneAndUpdate condition, update, (err, content)->
      if err then return res.status(400).send(err)
      return res.status(200).send(content)


