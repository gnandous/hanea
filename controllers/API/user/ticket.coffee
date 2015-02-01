validator = require '../../../libs/validator'
User = require '../../../models/user'
_ = require 'underscore'
Ticket = require '../../../models/Ticket'

module.exports =
  index: (req, res, next)->
    Ticket.find()
    .limit(20).exec (err, tickets)->
      if err
        next(err)
      return res.status(200).send(tickets)

  create: (req, res, next)->
    ticket = new Ticket req.body
    ticket.save (err, ticket)->
      if err then return res.status(400).send(err)
      return res.status(200).send(ticket)


  show: (req, res, next)->
    conditions =
      _id: req.params.id
    Ticket.findOne conditions, (err, ticket)->
      if err
        return res.status(400).send(err)
      return res.status(200).send(ticket)

## ticket is ticket finded by the query

  update: (req, res, next)->
    condition =
      _id: req.params.id
    update = req.body
    Ticket.findOneAndUpdate condition, update, (err, ticket)->
      if err then return res.status(400).send(err)
      return res.send ticket


  destroy: (req, res, next)->
    condition =
      _id: req.params.id
    Ticket.findOne condition, (err, ticket)->
      return res.status(404).send(err) unless ticket
      ticket.remove()
      Ticket.find()
      .sort(date:-1)
      .exec (err, tickets)->
        unless tickets
          return res.status(400).send(err)
        return res.status(200).send(tickets)
