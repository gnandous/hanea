define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "contenus", ($scope, $window, $http)->
    $scope.inputs =
      location : $("#addcontent").find("#location")
      title : $("#addcontent").find("#title")
      subtitle : $("#addcontent").find("#subtitle")
      content : $("#addcontent").find("#content")
      publication : $("#addcontent").find("#published")
    $scope.change = (event)->
      if $(document.activeElement).val()
        $(document.activeElement).removeClass('parsley-error')
        return true
      else
        $(document.activeElement).addClass('parsley-error')
        return false
    $scope.login = ()->
      $.ajax
        url: '/api/secure/content'
        type: 'POST'
        data:
          location : $scope.inputs.location.val()
          title : $scope.inputs.title.val()
          subtitle : $scope.inputs.subtitle.val()
          content : $scope.inputs.content.val()
          published : $scope.inputs.publication.is(':checked')
        success: (data)->
          console.log data
        error: (jqXHR, textStatus, errorThrown)=>
          switch jqXHR.status
            when 400
              errors = jqXHR.responseJSON
              if _.isArray errors
                _.each errors, (error, key, list)=>
                  @inputs[error.field].addClass('parsley-error')
