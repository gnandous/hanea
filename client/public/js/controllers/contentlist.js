(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("contentlist", function($scope, $window, $http, listOfContents) {
      console.log(listOfContents.data);
      return $scope.contents = listOfContents.data;
    });
  });

}).call(this);
