config = require '../../../config'
module.exports = (req, res, next) ->
  return res.render 'api/signin',
    title: config.site.title
