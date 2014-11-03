(function() {
  define(['angularAMD', 'jquery', 'tinymce'], function(angularAMD, $, tinymce) {
    return angularAMD.directive('editor', function() {
      return {
        restrict: 'A',
        link: function() {}
      };
    });
  });

}).call(this);
