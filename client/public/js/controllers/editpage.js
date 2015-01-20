(function() {
  define(['app', 'dropzone', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("EditPage", function($scope, $window, $location, AuthenticationService, $http, $routeParams, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.error = false;
        $scope.modeloldimg = "";
        $scope.addpageloader = true;
        $scope.addpageloadertxt = true;
        $scope.media = "";
        $http.get("/api/secure/page/" + $routeParams.id).success(function(data, status, headers, config) {
          $scope.modeloldimg = data.media;
          return $scope.model = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
        return $("#dropFile").dropzone({
          url: "/api/secure/page/file",
          thumbnailWidth: 250,
          thumbnailHeight: 150,
          previewTemplate: "<div></div>",
          success: function(file, data) {
            $scope.$apply(function() {
              $scope.model.to_remove = $scope.model.media;
              $scope.media = data.path;
              $scope.model.media = data.path;
              $scope.medianame = data.name;
              return $scope.model.medianame = data.name;
            });
            return $("#dropFile").html("<img width='100%' height='400px' src='/uploads/" + data.name + "'/>");
          }
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
        if ($scope.media_to_remove) {
          $scope.model.to_remove = $scope.modeloldimg;
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
