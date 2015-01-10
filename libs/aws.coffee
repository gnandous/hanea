AWS = require "aws-sdk"
fs = require 'fs'
config = require '../config'

AWS.config.update
  accessKeyId: config.aws.AWS_ACCESS_KEY
  secretAccessKey: config.aws.AWS_SECRET_KEY

s3 = new AWS.S3

exports.upload = (file, distPath, callback)->
  s3_params =
    Bucket: config.aws.S3_BUCKET
    Key: distPath
    ACL: 'public-read'
    Body:  file
  return s3.putObject s3_params, callback

exports.destroy = (distPath, callback)->
  s3_params =
    Bucket: config.aws.S3_BUCKET
    Key: distPath
  return s3.deleteObject s3_params, callback
