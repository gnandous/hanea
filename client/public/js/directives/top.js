(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('header', function() {
      return {
        restrict: 'A',
        templateUrl: "../templates/partials/header.html",
        controller: [
          '$scope', '$filter', function($scope, $filter) {
            $scope.click = function() {
              return alert("ok");
            };
            return $scope.message = "change from haha";
          }
        ]
      };
    });
  });

}).call(this);
