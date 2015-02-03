(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu', 'directives/loader'], function(app, $, _) {
    return app.controller("Letter", function($scope, $window, $http, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.content_state = false;
        $scope.lightbox = false;
        return $scope.stat = "Not upload yet";
      })();
      return $scope.Ctrl = {
        setFile: function() {
          $("#uplaoderCtrl").click();
        },
        loadFileFromDesktop: function(elem) {
          var haupload;
          return haupload = new HAUpload({
            name: "test",
            url: '/api/secure/article/file/post',
            file_dom_selector: "uplaoderCtrl"
          });
        }
      };
    });
  });

}).call(this);