config =
  session: require "./session"
  databases: require "./databases"
  success: require "./success"
  errors: require "./errors"
  server: require "./server"
  aws: require './aws'
  secret: "this is the secret secret secret 12356"
  mail:
  	email: "misteryou329@gmail.com"
  	pass: "beaucoup1"
  activation_protocol: "http://localhost:3000/activate/"
  site:
    title: "Hanea"
  misc:
    user:
      password:
        min: 6

module.exports = config
