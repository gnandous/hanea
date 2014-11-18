define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "articlelist", ($scope, $window, $http, $routeParams)->
    $scope.remove = (id)->
      $http.get("/api/secure/article/remove/#{id}").success((data, status, headers, config) ->
        $scope.contents = data
      ).error (data, status, headers, config) ->
        console.log status


    $scope.init = ()->
      $http.get("/api/secure/articles").success((data, status, headers, config) ->
        $scope.contents = data
      ).error (data, status, headers, config) ->
        console.log status
    $scope.init()
