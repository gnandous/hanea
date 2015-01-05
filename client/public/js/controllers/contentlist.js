(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("contentlist", function($scope, $window, $http, listOfContents, Model) {
      $scope.user = Model.data;
      $scope.contents = listOfContents.data;
      return $scope.remove = function(id) {
        $("tr[data-content=" + id + "]").hide();
        return $.ajax({
          url: '/api/secure/content/remove/' + id,
          type: 'GET',
          success: function(data) {},
          error: function(jqXHR, textStatus, errorThrown) {
            return console.log(jqXHR.status);
          }
        });
      };
    });
  });

}).call(this);
