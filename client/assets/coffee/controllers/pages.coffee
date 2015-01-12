define [
  'app'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "Pages", ($scope, $window, AuthenticationService, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.title = ""
      $scope.content = ""
      $http.get("/api/secure/pages").success((data, status, headers, config) ->
        $scope.pages = data
      ).error (data, status, headers, config) ->
        console.log status
    )()
