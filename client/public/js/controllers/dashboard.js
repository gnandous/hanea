(function() {
  define(['app', 'services/authentication'], function(app) {
    return app.controller("dashboard", function($scope, $window, AuthenticationService, $http, $routeParams, Model) {
      $scope.message = "Bienvenu sur la page dashboard Vous êtes connectés";
      $scope.user = {
        name: Model.data.name,
        email: "souleymane.gnandou@gmail.com",
        post: "Developpeur Node.js"
      };
      $scope.init = function() {
        return $http.get("/api/secure/content/all").success(function(data, status, headers, config) {
          $scope.contents = data;
          return console.log(data);
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      return $scope.init();
    });
  });

}).call(this);
