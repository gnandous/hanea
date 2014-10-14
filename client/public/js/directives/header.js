(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('header', function() {
      return {
        restrict: 'A',
        templateUrl: "/../templates/partials/header.html",
        controller: ['$scope', '$filter', function($scope, $filter) {}]
      };
    });
  });

}).call(this);
