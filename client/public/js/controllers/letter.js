(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu', 'directives/loader'], function(app, $, _) {
    return app.controller("Letter", function($scope, $window, $http, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.content_state = false;
        $scope.lightbox = false;
        $scope.stat = "Not upload yet";
        return $scope.progress = "0%;";
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
            file_dom_selector: "uplaoderCtrl",
            onProgress: function(percent, message) {
              return $scope.$apply(function() {
                return $scope.progress = percent + "%;";
              });
            },
            onFinishPut: function(publicUrl) {
              return console.log(publicUrl);
            }
          });
        }
      };
    });
  });

}).call(this);
