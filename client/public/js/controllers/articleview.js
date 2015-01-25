(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("ArticleView", function($scope, $window, $http, $routeParams, Model) {
      $scope.user = Model.data;
      $scope.init = function() {
        return $http.get("/api/secure/article/" + $routeParams.id).success(function(data, status, headers, config) {
          return $scope.article = data;
        }).error(function(data, status, headers, config) {
          return console.log(data);
        });
      };
      return $scope.init();
    });
  });

}).call(this);
