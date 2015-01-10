(function() {
  define(['app', 'services/authentication'], function(app) {
    return app.controller("EditParagraphe", function($scope, $window, AuthenticationService, $http, $routeParams, Model) {
      $scope.user = Model.data;
      $http.get("/api/secure/paragraphe/" + $routeParams.id).success(function(data, status, headers, config) {
        return $scope.paragraphe = data;
      }).error(function(data, status, headers, config) {
        return console.log(status);
      });
      return $scope.update = function() {
        if (!this.paragraphe.content) {
          this.content_state = true;
          return null;
        }
        return $.ajax({
          url: "/api/secure/paragraphe/" + $routeParams.id,
          type: 'POST',
          data: $scope.paragraphe,
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
