(function() {
  define(['app'], function(app) {
    return app.factory("AuthenticationService", function($window, $http) {
      return {
        login: function(user) {
          return $http.post("/api/login", user);
        },
        logout: function($scope) {
          $.removeCookie('hanea_session', {
            path: '/'
          });
          $scope.welcome = "";
          $scope.message = "";
          $scope.isAuthenticated = false;
          return delete $window.sessionStorage.token;
        }
      };
    });
  });

}).call(this);
