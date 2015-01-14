crypto = require('crypto')


module.exports =
  Slugify: (title) ->
    preSlug = title.toString().toLowerCase().replace(/\s+/g, "-").replace(/[^\w\-]+/g, "").replace(/\-\-+/g, "-").replace(/^-+/, "").replace /-+$/, ""
    Slug = preSlug + "-#{crypto.randomBytes(4).toString('hex')}"
