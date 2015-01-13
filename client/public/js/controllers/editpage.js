(function() {
  define(['app', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("EditPage", function($scope, $window, $location, AuthenticationService, $http, $routeParams, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.error = false;
        return $http.get("/api/secure/page/" + $routeParams.id).success(function(data, status, headers, config) {
          return $scope.model = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      })();
      $scope.validate = function() {
        if (!this.model.content) {
          this.error = true;
          this.message = "Content can not be blank";
          return false;
        }
        if (!this.model.title) {
          this.error = true;
          this.message = "Title can not be blank";
          return false;
        }
        return true;
      };
      return $scope.update = function() {
        if (!this.validate()) {
          return null;
        }
        return $http.post("/api/secure/page/" + $routeParams.id, $scope.model).success(function(data, status, headers, config) {
          $scope.resErr = false;
          console.log(data);
          $location.path("/api/pages");
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
    });
  });

}).call(this);
