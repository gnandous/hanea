define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "stafflist", ($scope, $window, $http, $routeParams)->

    $scope.init = ()->
      $http.get("/api/secure/staffs").success((data, status, headers, config) ->
        $scope.stafflist = data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.init()