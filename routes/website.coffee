express = require 'express'
websiteRouter = express.Router()

module.exports = () ->
	websiteRouter.get '/', (req, res, next)->
		return res.render 'index',
      title: 'Hello'
