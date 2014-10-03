define [
  'app'
  'services/authentication'
], (app, $)->
  app.controller "dashboard", ($scope, $window, AuthenticationService, $http)->
    $scope.message = "hello are you good ? Tu vas bien ? c'est le mndp"
    #console.log("soul")
