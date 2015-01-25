aws = require 'aws-sdk'
randomToken = require 'random-token'
_ = require 'underscore'
config = require '../../../config'
Staff = require '../../../models/staff'
AWS = require '../../../libs/aws'
sendToAmazon = (s3_object_type, s3_object_name, callback) ->
  aws.config.update
    accessKeyId: config.aws.AWS_ACCESS_KEY
    secretAccessKey: config.aws.AWS_SECRET_KEY
  s3 = new aws.S3
  s3_params =
    Bucket: config.aws.S3_BUCKET
    Key: s3_object_name
    Expires: 60
    ContentType: s3_object_type
    ACL: 'public-read'
  s3.getSignedUrl "putObject", s3_params, callback

module.exports =
  create: (req, res, next)->
    staff = new Staff
      name : req.body.name
      lastname : req.body.lastname
      bio: req.body.bio
      role: req.body.role
      avatar: req.body.avatar

    staff.save (err, staff)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(staff)

  index: (req, res, next)->
    Staff.find().limit(20).exec (err, staffs)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(staffs)

  show: (req, res, next)->
    Staff.findOne
      _id: req.params.id
    , (err, member)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(member)

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    Staff.findOne condition, (err, staffmember)->
      if err
        return res.status(400).send(err)
      staffmember = _.extend staffmember, update
      staffmember.save (err, member)->
        if err
          return res.status(400).send(err)
        return res.status(200).send(member)

  destroy: (req, res, next)->
    str = "https://hanea-assets.s3.amazonaws.com/"
    condition =
      _id: req.params.id
    #Staff.findOneAndRemove condition,
    Staff.findOneAndRemove condition, (err, staff)->
      if err
        return res.status(400).send(err)
      distPath = staff.avatar.slice(str.length)
      AWS.destroy distPath, (err, data)->
        if err then res.status(404).send(err)
        res.send 200

  ## send files direct to amazon and return url access
  mys3: (req, res, next) ->
    s3token = randomToken(8)
    dispath = "user-#{req.user.id}/#{s3token}"
    sendToAmazon req.query.s3_object_type, dispath, (err, data)->
      if err
        console.log err
      else
        return_data =
          signed_request: data
          url: "https://" + config.aws.S3_BUCKET + ".s3.amazonaws.com/" + dispath
        res.write JSON.stringify(return_data)
        res.end()
