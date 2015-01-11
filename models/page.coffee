mongoose = require 'mongoose'
Schema = mongoose.Schema

PageSchema = new Schema
  title:
    type: String
  media:
    type: String
  content:
    type: String
    required: true
module.exports = Page = mongoose.model 'Page', PageSchema
