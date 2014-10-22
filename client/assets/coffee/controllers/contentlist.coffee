define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "contentlist", ($scope, $window, $http, listOfContents)->
    $scope.contents = listOfContents.data
