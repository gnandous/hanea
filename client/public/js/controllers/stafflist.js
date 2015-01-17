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
      $scope.init();
      return $scope.remove = function(id) {
        $("div[data-element=" + id + "]").parent().hide('slow', function() {});
        return $http.get("/api/secure/staff/remove/" + id).success(function(data, status, headers, config) {
          return console.log(data);
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
    });
  });

}).call(this);
