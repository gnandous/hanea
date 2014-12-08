(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("stafflist", function($scope, $window, $http, $routeParams, Model) {
      $scope.user = Model.data;
      $scope.init = function() {
        return $http.get("/api/secure/staffs").success(function(data, status, headers, config) {
          return $scope.stafflist = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      return $scope.init();
    });
  });

}).call(this);
