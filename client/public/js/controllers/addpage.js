(function() {
  define(['app', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("AddPage", function($scope, $window, AuthenticationService, $http, $routeParams, $location, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.title = "";
        return $scope.content = "";
      })();
      $scope.validate = function() {
        if (!this.content) {
          this.error = true;
          this.message = "Content can not be blank";
          return false;
        }
        if (!this.title) {
          this.error = true;
          this.message = "Title can not be blank";
          return false;
        }
        return true;
      };
      return $scope.create = function() {
        if (!this.validate()) {
          return null;
        }
        $scope.model = {
          title: $scope.title,
          content: $scope.content
        };
        return $http.post("/api/secure/page", $scope.model).success(function(data, status, headers, config) {
          $scope.resErr = false;
          $location.path("/api/pages");
        }).error(function(data, status, headers, config) {
          return console.log(config);
        });
      };
    });
  });

}).call(this);
