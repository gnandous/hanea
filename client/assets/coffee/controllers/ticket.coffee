define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "Ticket", ($scope, $window, $http, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.content_state = false
      $scope.lightbox = false
    )()

    $scope.ctrl =
      addNewIssue: ()->
        $scope.lightbox = true
      hideLightBox: ()->
        $scope.lightbox = false
