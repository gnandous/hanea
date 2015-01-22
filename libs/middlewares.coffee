Article = require '../models/article'
Page = require '../models/Page'
async = require 'async'

module.exports =
  findBySlug: (req, res, next, slug)->
    condition =
      slug: slug
    Page.findOne condition, (err, page)->
      if page
        req.page = page
        next()
      else
        ## search article by slug
        next()

