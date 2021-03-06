(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("articlelist", function($scope, $window, $http, $routeParams, Model) {
      $scope.user = Model.data;
      $scope.remove = function(id) {
        $("tr[data-content=" + id + "]").hide();
        return $http.get("/api/secure/article/remove/" + id).success(function(data, status, headers, config) {
          return $scope.removed = true;
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
