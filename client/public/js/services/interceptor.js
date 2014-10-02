(function() {
  define(['angularAMD', 'jquery', 'jquery_cookie', 'angular_route'], function(angularAMD, $) {
    var auth;
    auth = angular.module('Authorization', ['ngRoute']);
    return auth.factory('authInterceptor', function($rootScope, $q, $window, $location) {
      return {
        request: function(config) {
          if (!$.cookie("hanea_session")) {
            $location.path("/api/login");
          }
          return config;
        },
        response: function(response) {
          return response || $q.when(response);
        }
      };
    });
  });

}).call(this);
