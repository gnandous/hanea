express = require 'express'
websiteRouter = express.Router()

module.exports = () ->
	websiteRouter.get '/', (req, res, next)->
		return res.render 'website/home/home',
      title: 'Hello'
  return websiteRouter
