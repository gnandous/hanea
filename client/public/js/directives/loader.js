(function() {
  define(['angularAMD'], function(angularAMD) {
    return angularAMD.directive('loader', function() {
      return {
        restrict: 'E',
        scope: {
          progress: '=progressbar'
        },
        link: function($scope, $el, attrs) {
          return console.log($el.children().find(".uploadbar"));
        },
        template: "<div class='uploadbar' style='width:{{progress}}'></div>"
      };
    });
  });

}).call(this);
