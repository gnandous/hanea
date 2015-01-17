define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "stafflist", ($scope, $window, $http, $routeParams, Model)->
    $scope.user = Model.data

    $scope.init = ()->
      $http.get("/api/secure/staffs").success((data, status, headers, config) ->
        $scope.stafflist = data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.init()

    $scope.remove = (id)->
      $("div[data-element=#{id}]").parent().hide 'slow', ()->
      $http.get("/api/secure/staff/remove/#{id}").success((data, status, headers, config) ->
        console.log data
      ).error (data, status, headers, config) ->
        console.log status
