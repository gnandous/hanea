define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "contentlist", ($scope, $window, $http, listOfContents)->
    console.log listOfContents.data
    $scope.contents = listOfContents.data
