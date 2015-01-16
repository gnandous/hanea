(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('ng-enter', function($scope, element, attrs) {
      return element.bind("keydown keypress", function(event) {
        if (event.which !== 13) {
          event.preventDefault;
        }
        return $scope.$eval(attrs.ngEnter, {
          'event': event
        });
      });
    });
  });

}).call(this);
