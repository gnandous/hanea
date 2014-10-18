(function() {
  define(['app', 'jquery', 'jquery_cookie', 'services/authentication'], function(app, $, foggy) {
    return app.controller('UserCtrl', function($rootScope, $scope, $window, AuthenticationService, $http) {
      $scope.user = {
        username: "gnandou@gmail.com",
        password: "idegnandou"
      };
      $rootScope.user = "MacBookPro";
      $scope.errormsg = "false";
      $scope.message = "";
      $scope.welcome = "";
      $scope.isAuthenticated = false;
      $scope.submit = function() {
        if ($scope.user !== undefined) {
          return AuthenticationService.login($scope.user).success(function(data, status, headers, config) {
            var cookieOptions;
            $scope.isAuthenticated = true;
            $scope.message = "Welcome";
            cookieOptions = {
              path: '/',
              expires: 365
            };
            $.cookie('hanea_session', data._id, cookieOptions);
            return window.location = '/api/';
          }).error(function(data, status) {
            $scope.isAuthenticated = false;
            $scope.error = data;
            $scope.errormsg = true;
            return $scope.welcome = "";
          });
        }
      };
      $scope.logout = function() {
        return AuthenticationService.logout(this);
      };
      return $scope.callRestricted = function() {
        return $http({
          url: "/api/secure/welcome",
          method: "GET"
        }).success(function(data, status, headers, config) {
          return $scope.message = $scope.message + data;
        }).error(function(data, status, headers, config) {
          return $scope.message = $scope.message + data;
        });
      };
    });
  });

}).call(this);
