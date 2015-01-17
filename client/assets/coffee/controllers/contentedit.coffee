define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "contentedit", ($scope, $window, $http, $routeParams, Model)->
    $scope.inputs =
      location : $("#addcontent").find("#location")
      title : $("#addcontent").find("#title")
      subtitle : $("#addcontent").find("#subtitle")
      content : ""
      publication : $("#addcontent").find("#published")

    $scope.init = ()->
      $scope.user = Model.data
      $http.get("/api/secure/content/detail/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.model = data
        $scope.inputs.content = data.content
      ).error (data, status, headers, config) ->
        console.log status
    $scope.change = (event)->
      if $(document.activeElement).val()
        $(document.activeElement).removeClass('parsley-error')
        return true
      else
        $(document.activeElement).addClass('parsley-error')
        return false
    $scope.update = ()->
      $.ajax
        url: "/api/secure/content/update/#{$routeParams.id}"
        type: 'POST'
        data:
          location : $scope.inputs.location.val()
          title : $scope.inputs.title.val()
          subtitle : $scope.inputs.subtitle.val()
          content :  $scope.inputs.content
          published : $scope.inputs.publication.is(':checked')
        success: (data)->
          $(".message .alert").html("<i class='fa fa-check'></i> Your post has been Updated succesfully. Thank You. <strong> <a href='/api/articles'>See content</a></strong>")
          $(".message .alert").fadeIn()
          $('html, body').animate(
            scrollTop: 0
          , 300)
        error: (jqXHR, textStatus, errorThrown)=>
          switch jqXHR.status
            when 400
              errors = jqXHR.responseJSON
              if _.isArray errors
                _.each errors, (error, key, list)=>
                  unless key
                    $('html, body').animate(
                      scrollTop: @inputs[error.field].offset().top - 30
                    , 500)
                  @inputs[error.field].addClass('parsley-error')
    $scope.init()
