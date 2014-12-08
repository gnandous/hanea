define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "contentlist", ($scope, $window, $http, listOfContents, Model)->
    $scope.user = Model.data
    $scope.contents = listOfContents.data
    $scope.remove = (id)->
      $.ajax
        url: '/api/secure/content/remove/' + id
        type: 'GET'
        success: (data)->
          $scope.$apply ()->
            $scope.contents = data
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status

