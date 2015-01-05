(function() {
  define(['app', 'services/authentication'], function(app) {
    return app.controller("dashboard", function($scope, $window, AuthenticationService, $http, $routeParams, Model) {
      $scope.user = {
        name: Model.data.name,
        email: Model.data.email,
        _id: Model.data._id,
        avatar: Model.data.avatar
      };
      $scope.init = function() {
        return $http.get("/api/secure/content/all").success(function(data, status, headers, config) {
          return $scope.contents = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      return $scope.init();
    });
  });

}).call(this);
