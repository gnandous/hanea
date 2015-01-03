define [
  'app'
  'services/authentication'
], (app) ->
  app.controller "dashboard", ($scope, $window, AuthenticationService, $http, $routeParams, Model)->
    $scope.message = "Bienvenu sur la page dashboard Vous êtes connectés"
    $scope.user =
      name: Model.data.name
      email: Model.data.email
      _id: Model.data._id
      avatar: Model.data.avatar

    $scope.init = ()->
      $http.get("/api/secure/content/all").success((data, status, headers, config) ->
        $scope.contents = data
        console.log data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.init()
