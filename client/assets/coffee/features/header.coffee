define [
  'jquery'
  'underscore'
  'text!/../../templates/header.html'
], ($, _, header)->
  class headerView
    el: '.navbar .container'

    template2: _.template ""
    template: _.template header
    constructor: ()->

    render: ->
      unless $.cookie("hanea_session")
        $(@el).html(@template2)
      else
        $(@el).html(@template)
