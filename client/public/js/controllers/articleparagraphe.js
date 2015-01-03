(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("ArticleParagraphe", function($scope, $window, $http, $routeParams, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.paragraphe = {};
        $scope.paragraphe.article_id = $routeParams.id;
        $scope.content_state = false;
        return $scope.success = false;
      })();
      return $scope.create = function() {
        if (!this.paragraphe.content) {
          this.content_state = true;
          return null;
        }
        return $.ajax({
          url: "/api/secure/article/" + $routeParams.id + "/paragraphe",
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
