(function() {
  define(['app', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("Pages", function($scope, $window, AuthenticationService, $http, $routeParams, Model) {
      return $scope.init = (function() {
        $scope.user = Model.data;
        $scope.title = "";
        $scope.content = "";
        return $http.get("/api/secure/pages").success(function(data, status, headers, config) {
          return $scope.pages = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      })();
    });
  });

}).call(this);
