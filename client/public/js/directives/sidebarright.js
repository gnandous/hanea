(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('sidebarright', function() {
      return {
        restrict: 'A',
        templateUrl: "../templates/partials/sidebarright.html",
        controller: ['$scope', '$filter', function($scope, $filter) {}]
      };
    });
  });

}).call(this);
