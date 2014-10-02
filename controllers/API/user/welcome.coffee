config = require '../../../config'
module.exports = (req, res, next) ->
  return res.render 'api/index',
    title: config.site.title
