define [
  'app'
  'services/authentication'
], (app)->
  app.controller "dashboard", ($scope, $window, AuthenticationService, $http, Model)->
    console.log Model.data
    $scope.message = "Bienvenu sur la page dashboard Vous êtes connectés"
    $scope.user =
      name: Model.data.name
      email: "souleymane.gnandou@gmail.com"
      post: "Developpeur Node.js"
