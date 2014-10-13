(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('contentmenu', function() {
      return {
        restrict: 'A',
        templateUrl: "../templates/partials/contentmenu.html",
        controller: ['$scope', '$filter', function($scope, $filter) {}]
      };
    });
  });

}).call(this);
