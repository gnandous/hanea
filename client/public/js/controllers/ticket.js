(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("Ticket", function($scope, $window, $http, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.content_state = false;
        return $scope.lightbox = false;
      })();
      return $scope.ctrl = {
        addNewIssue: function() {
          return $scope.lightbox = true;
        },
        hideLightBox: function() {
          return $scope.lightbox = false;
        }
      };
    });
  });

}).call(this);
