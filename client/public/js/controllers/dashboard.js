(function() {
  define(['app', 'services/authentication'], function(app) {
    return app.controller("dashboard", function($scope, $window, AuthenticationService, $http) {
      return $scope.message = "hello are you good ? Tu vas bien ? c'est le mndp";
    });
  });

}).call(this);
