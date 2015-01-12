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
  slug:
    type: String
module.exports = Page = mongoose.model 'Page', PageSchema
