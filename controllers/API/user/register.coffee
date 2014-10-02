validator = require '../../../libs/validator'
User = require '../../../models/user'
config = require '../../../config/'
bcrypt = require 'bcrypt'

module.exports = (req, res, next) ->
  errors = []
  unless req.body.name
    errors.push
      field: 'name'
      error: 'name must be filled'
      value: req.body.name
  unless req.body.email
    errors.push
      field: 'email'
      error: 'email must be filled'
      value: req.body.email
  else unless validator.isEmail req.body.email
    errors.push
      field: 'email'
      error: 'Email must be a valid email'
      value: req.body.email
  unless req.body.password
    errors.push
      field: 'password'
      error: 'Password must be filled'
  else if req.body.password.length < config.misc.user.password.min
    errors.push
      field: 'password'
      error: "Password must be at least #{config.misc.user.password.min} characters"
  if req.body.password isnt req.body.passwordConfirm
    errors.push
      field: 'passwordConfirm'
      error: 'Passwords are not equal'
  else unless req.body.passwordConfirm
    errors.push
      field: 'passwordConfirm'
      error: 'Password confirmation must be filled'
  if errors.length
     return res.status(400).send(errors)

  User.ifexist
    email: req.body.email
  ,(err, user)->
    if user
      errors.push
        field: 'signin'
        error: 'Email already Exists'
      return res.status(400).send errors
    else
      bcrypt.genSalt 10, (err, salt)->
        bcrypt.hash req.body.password, salt, (err, hash)->
          if err
            console.log err
            next()
          newuser = new User
            name: req.body.name
            email: req.body.email
            password: hash
            token: User.generateToken()
          newuser.save (err, user)->
            if err
              res.status(400).send(message: "An error had been occured")
            res.status(200).send("user has been created")
