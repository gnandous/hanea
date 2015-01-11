mongoose = require 'mongoose'
Schema = mongoose.Schema

CategorySchema = new Schema
  name:
    type: String
module.exports = Category = mongoose.model 'Category', CategorySchema
