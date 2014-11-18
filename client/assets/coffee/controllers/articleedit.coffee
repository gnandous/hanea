define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "articleedit", ($scope, $window, $http, $routeParams)->
    $scope.init = ()->
      $http.get("/api/secure/article/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.model = data
        console.log data
      ).error (data, status, headers, config) ->
        console.log data
    $scope.update = ->
      $.ajax
        url: "/api/secure/article/update/#{$routeParams.id}"
        type: 'POST'
        data: @model
        success: (data)->
          $scope.$apply ()->
            $scope.errors = {}
          $(".message .alert").html("<i class='fa fa-check'></i> Your post has been Updated succesfully. Thank You. <strong> <a href='/api/articles'>See content</a></strong>")
          $(".message .alert").fadeIn()
          $('html, body').animate(
            scrollTop: 0
          , 300)
        error: (jqXHR, textStatus, errorThrown)=>
          switch jqXHR.status
            when 400
              errors = jqXHR.responseJSON.errors
              $scope.$apply ()->
                $scope.errors = errors
          $('html, body').animate(
            scrollTop: 0
            , 500)
    $scope.init()
