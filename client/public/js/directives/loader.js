(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('loader', function() {
      return {
        scope: {
          loader: "=",
          status: '='
        },
        link: function($scope, $elem, attrs) {
          console.log(attrs);
          return console.log($scope.status);
        }
      };
    });
  });

}).call(this);
