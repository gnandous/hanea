define [
  'app'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "AddPage", ($scope, $window, AuthenticationService, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.title = ""
      $scope.content = ""
    )()

    ## validate function ()
    $scope.validate = ()->
      unless @content
        this.error = true
        this.message = "Content can not be blank"
        return false
      unless @title
        this.error = true
        this.message = "Title can not be blank"
        return false

      return true

    $scope.create = ()->
      unless @validate()
        return null
      $.ajax
        #url: "/api/secure/article/update/#{$routeParams.id}"
        url : "/api/secure/page"
        type: 'POST'
        data:
          title: $scope.title
          content: $scope.content
        success: (data)->
          $scope.$apply ()->
            $scope.success = true
          console.log data
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status

