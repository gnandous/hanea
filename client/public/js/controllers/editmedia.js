(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("EditMedia", function($scope, $window, $http, $routeParams, Model) {
      $scope.init = (function() {
        $http.get("/api/secure/media/" + $routeParams.media_id).success(function(data, status, headers, config) {
          return $scope.media_to_edit = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
        $scope.user = Model.data;
        $scope.media = {};
        $scope.media.article_id = $routeParams.id;
        $scope.content_state = false;
        $scope.success = false;
        $scope.article_id = $routeParams;
        return $("#dropFile").dropzone({
          url: "/api/secure/article/" + $routeParams.media_id + "/media",
          thumbnailWidth: 250,
          thumbnailHeight: 150,
          previewTemplate: "<div></div>",
          success: function(file, data) {
            $scope.$apply(function() {
              return $scope.media.content = data;
            });
            return $("#dropFile").append("<img width='100%' height='400px' src='/uploads/" + data + "'/>");
          }
        });
      })();
      return $scope.update = function() {
        return $.ajax({
          url: "/api/secure/media/" + $routeParams.media_id,
          type: 'POST',
          data: $scope.media,
          success: function(data) {
            return $scope.$apply(function() {
              $scope.success = true;
              return $scope.media_to_edit = data;
            });
          },
          error: function(jqXHR, textStatus, errorThrown) {
            return console.log(jqXHR.status);
          }
        });
      };
    });
  });

}).call(this);
