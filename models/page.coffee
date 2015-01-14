mongoose = require 'mongoose'
Schema = mongoose.Schema
Slug = require '../libs/slug'

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

PageSchema.pre "save", (next, done)->
  unless @title
    done new Error("Slug can not be generated without title")
  @slug = Slug.Slugify @title
  next()

module.exports = Page = mongoose.model 'Page', PageSchema
