config =
  secret: "3project"
  cookie:
    name: '3project_session'
    expire: -> new Date(Date.now() + 604800000)
    path: '/'
module.exports = config
