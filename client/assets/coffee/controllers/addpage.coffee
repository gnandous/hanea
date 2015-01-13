define [
  'app'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "AddPage", ($scope, $window, AuthenticationService, $http, $routeParams,$location, Model)->
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
      $scope.model =
        title: $scope.title
        content: $scope.content
      $http.post("/api/secure/page", $scope.model).success((data, status, headers, config) ->
        $scope.resErr = false
        $location.path "/api/pages"
        return
      ).error (data, status, headers, config) ->
        console.log status

