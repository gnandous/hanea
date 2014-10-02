config = require '../../../config'
User = require '../../../models/user'


module.exports = (req, res, next) ->
  User.findOne
    email: req.body.username
  , (err, user)->
    if user
      user.comparePassword req.body.password, (err, isMatch)->
        return res.status(200).send(user) if isMatch
        return res.status(401).send("Invalid User/Password")
    else
      return res.status(401).send("User dont exists")
