(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("ArticleMedia", function($scope, $window, $http, $routeParams, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.media = {};
        $scope.media.article_id = $routeParams.id;
        $scope.content_state = false;
        $scope.success = false;
        $scope.article_id = $routeParams;
        return $("#dropFile").dropzone({
          url: "/api/secure/article/" + $routeParams + "/media",
          thumbnailWidth: 250,
          thumbnailHeight: 150,
          previewTemplate: "<div></div>",
          success: function(file, data) {
            $scope.$apply(function() {
              console.log(data.file.name);
              $scope.media.content = data.file.path;
              return $scope.media.medianame = data.file.name;
            });
            return $("#dropFile").append("<img width='100%' height='400px' src='/uploads/" + data.file.name + "'/>");
          }
        });
      })();
      return $scope.create = function() {
        return $.ajax({
          url: "/api/secure/article/" + $routeParams.id + "/media",
          type: 'POST',
          data: $scope.media,
          success: function(data) {
            console.log(data);
            return $scope.$apply(function() {
              return $scope.success = true;
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
