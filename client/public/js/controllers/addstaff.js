(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("addstaff", function($scope, $window, $http, $routeParams) {
      var s3_upload;
      $scope.change = function(event) {
        if ($(document.activeElement).val()) {
          $(document.activeElement).removeClass('parsley-error');
          return true;
        } else {
          $(document.activeElement).addClass('parsley-error');
          return false;
        }
      };
      s3_upload = function() {
        var preview_elem, s3upload, status_elem;
        status_elem = document.getElementById("status");
        preview_elem = document.getElementById("preview");
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
              status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url;
              img = "<img src='" + public_url + "' width='150' height='150' id='avatar_preview' />";
              $("#preview").html(img);
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
