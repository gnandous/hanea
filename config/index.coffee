config =
  session: require "./session"
  databases: require "./databases"
  server: require "./server"
  secret: "this is the secret secret secret 12356"
  mail:
  	email: "misteryou329@gmail.com"
  	pass: "beaucoup1"
  activation_protocol: "http://localhost:3000/activate/"
  site:
    title: "Haute Autorité Nigérienne à L'énergie atomique"
  misc:
    user:
      password:
        min: 6

module.exports = config
