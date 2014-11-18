(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("articlelist", function($scope, $window, $http, $routeParams) {
      $scope.remove = function(id) {
        return $http.get("/api/secure/article/remove/" + id).success(function(data, status, headers, config) {
          return $scope.contents = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      $scope.init = function() {
        return $http.get("/api/secure/articles").success(function(data, status, headers, config) {
          return $scope.contents = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      return $scope.init();
    });
  });

}).call(this);
