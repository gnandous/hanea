(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("User", function($scope, $window, $http, $routeParams, Model) {
      var s3_upload;
      $scope.user = Model.data;
      $scope.update = function() {
        return $.ajax({
          url: "/api/secure/user/" + $scope.user._id + "/update",
          type: 'POST',
          data: $scope.user,
          success: function(data) {
            $(".message .alert").html("<i class='fa fa-check'></i> User has been Updated succesfully.");
            $(".message .alert").fadeIn();
            $('html, body').animate({
              scrollTop: 0
            }, 500);
            return console.log(data);
          },
          error: (function(_this) {
            return function(jqXHR, textStatus, errorThrown) {
              return console.log(jqXHR.status);
            };
          })(this)
        });
      };
      s3_upload = function() {
        var file, preview_elem, s3upload, status_elem;
        status_elem = document.getElementById("status");
        preview_elem = document.getElementById("preview");
        file = document.getElementById("files");
        return s3upload = new S3Upload({
          file_dom_selector: "files",
          s3_sign_put_url: "/api/secure/sign_s3",
          s3_object_name: "user01-img",
          onProgress: function(percent, message) {
            status_elem.innerHTML = "Upload progress: " + percent + "% " + message;
            $(".progress").css('display', 'block');
            $("div[role='progressbar']").css('width', "" + percent + "%");
          },
          onFinishS3Put: (function(_this) {
            return function(public_url) {
              var img;
              img = "<img src='" + public_url + "' width='150' height='150' id='avatar_preview' />";
              $("#preview").html(img);
              $scope.user.avatar = public_url;
            };
          })(this),
          onError: function(status) {
            status_elem.innerHTML = "Upload error: " + status;
          }
        });
      };
      return (function() {
        var input_element;
        input_element = document.getElementById("files");
        input_element.onchange = s3_upload;
      })();
    });
  });

}).call(this);
