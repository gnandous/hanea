define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "articlelist", ($scope, $window, $http, $routeParams, Model)->
    $scope.user = Model.data
    $scope.remove = (id)->
      $("tr[data-content=#{id}]").hide()
      $http.get("/api/secure/article/remove/#{id}").success((data, status, headers, config) ->
        $scope.removed = true
      ).error (data, status, headers, config) ->
        console.log status


    $scope.init = ()->
      $http.get("/api/secure/articles").success((data, status, headers, config) ->
        $scope.contents = data
      ).error (data, status, headers, config) ->
        console.log status
    $scope.init()
