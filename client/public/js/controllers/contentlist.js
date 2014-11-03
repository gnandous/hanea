(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("contentlist", function($scope, $window, $http, listOfContents) {
      $scope.contents = listOfContents.data;
      return $scope.remove = function(id) {
        return $.ajax({
          url: '/api/secure/content/remove/' + id,
          type: 'GET',
          success: function(data) {
            return $scope.$apply(function() {
              return $scope.contents = data;
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
