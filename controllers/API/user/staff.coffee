aws = require 'aws-sdk'
config = require '../../../config'

module.exports =
  create: (req, res, next)->
    console.log ("staff create")

  mys3: (req, res, next) ->
    aws.config.update
      accessKeyId: config.aws.AWS_ACCESS_KEY
      secretAccessKey: config.aws.AWS_SECRET_KEY
    s3 = new aws.S3
    s3_params =
      Bucket: config.aws.S3_BUCKET
      Key: req.query.s3_object_name
      Expires: 60
      ContentType: req.query.s3_object_type
      ACL: 'public-read'
    s3.getSignedUrl "putObject", s3_params, (err, data)->
      if err
        console.log err
      else
        return_data =
          signed_request: data
          url: "https://" + config.aws.S3_BUCKET + ".s3.amazonaws.com/" + req.query.s3_object_name
        res.write JSON.stringify(return_data)
        res.end()
