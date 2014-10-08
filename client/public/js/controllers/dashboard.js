(function() {
  define(['app', 'services/authentication'], function(app) {
    return app.controller("dashboard", function($scope, $window, AuthenticationService, $http) {
      $scope.message = "Bienvenu sur la page dashboard Vous êtes connectés";
      return $scope.user = {
        name: "souleymane",
        email: "souleymane.gnandou@gmail.com",
        post: "Developpeur Node.js"
      };
    });
  });

}).call(this);
