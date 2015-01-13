define [
  'app'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "EditPage", ($scope, $window, $location, AuthenticationService, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.error = false
      $http.get("/api/secure/page/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.model = data
      ).error (data, status, headers, config) ->
        console.log status
    )()

    $scope.validate = ()->
      unless @model.content
        this.error = true
        this.message = "Content can not be blank"
        return false
      unless @model.title
        this.error = true
        this.message = "Title can not be blank"
        return false

      return true
    $scope.update = ()->
      unless @validate()
        return null
      $http.post("/api/secure/page/#{$routeParams.id}", $scope.model).success((data, status, headers, config) ->
        $scope.resErr = false
        console.log data
        $location.path "/api/pages"
        return
      ).error (data, status, headers, config) ->
        console.log status
