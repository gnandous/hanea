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
      $("tr[data-content=#{id}]").hide()
      $.ajax
        url: '/api/secure/content/remove/' + id
        type: 'GET'
        success: (data)->

        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status

