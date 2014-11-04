(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("addstaff", function($scope, $window, $http, $routeParams) {
      var s3_upload;
      console.log("add staff controller ...");
      s3_upload = function() {
        var preview_elem, s3upload, status_elem, url_elem;
        status_elem = document.getElementById("status");
        url_elem = document.getElementById("avatar_url");
        preview_elem = document.getElementById("preview");
        return s3upload = new S3Upload({
          file_dom_selector: "files",
          s3_sign_put_url: "/api/secure/sign_s3",
          onProgress: function(percent, message) {
            status_elem.innerHTML = "Upload progress: " + percent + "% " + message;
          },
          onFinishS3Put: function(public_url) {
            status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url;
            url_elem.value = public_url;
            preview_elem.innerHTML = "<img src=\"" + public_url + "\" style=\"width:300px;\" />";
          },
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
