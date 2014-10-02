emailer		= require "nodemailer"
fs			= require "fs"
_ = require 'underscore'
config		= require("../config")


class Emailer
	options: {}
	data:{}

	constructor: (@options, @data) ->

	send: (callback) ->
		html = @getHtml(@options.template, @data)
		mailOptions = 
			to: "<#{@options.to.email}>"
			from : "3project corporation <3@project.com>"
			subject: @options.to.subject
			html:html
			generateTextFromHTML: true
		transport = @getTransport()
		transport.sendMail mailOptions, callback


	getTransport: () ->
		emailer.createTransport("SMTP",
			service: "Gmail"
			auth:
				user: config.mail.email
				pass: config.mail.pass
				)
	getHtml: (templateName, data) ->
		templatePath = "./views/emails/#{templateName}.html"
		templateContent = fs.readFileSync(templatePath, encoding= "utf8")
		_.template templateContent, data, {interpolate: /\{\{(.+?)\}\}/g}


exports = module.exports = Emailer

