define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "ArticleView", ($scope, $window, $http, $routeParams, Model)->
    $scope.user = Model.data
    $scope.init = ()->
      $http.get("/api/secure/article/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.article = data
      ).error (data, status, headers, config) ->
        console.log data
    $scope.init()
