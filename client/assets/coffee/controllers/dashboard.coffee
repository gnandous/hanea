define [
  'app'
  'services/authentication'
], (app)->
  app.controller "dashboard", ($scope, $window, AuthenticationService, $http)->
    $scope.message = "Bienvenu sur la page dashboard Vous êtes connectés"
    $scope.user =
      name: "souleymane"
      email: "souleymane.gnandou@gmail.com"
      post: "Developpeur Node.js"
