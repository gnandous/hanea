(function() {
  define(['app', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("AddPage", function($scope, $window, AuthenticationService, $http, $routeParams, Model) {
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
        return $.ajax({
          url: "/api/secure/page",
          type: 'POST',
          data: {
            title: $scope.title,
            content: $scope.content
          },
          success: function(data) {
            $scope.$apply(function() {
              return $scope.success = true;
            });
            return console.log(data);
          },
          error: function(jqXHR, textStatus, errorThrown) {
            return console.log(jqXHR.status);
          }
        });
      };
    });
  });

}).call(this);
