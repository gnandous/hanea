(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("staffedit", function($scope, $window, $http, $routeParams, Model) {
      var s3_upload;
      $scope.init = function() {
        $scope.user = Model.data;
        return $http.get("/api/secure/staff/show/" + $routeParams.id).success(function(data, status, headers, config) {
          $scope.model = data;
          return console.log(data);
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      $scope.init();
      $scope.update = function() {
        return $.ajax({
          url: '/api/secure/staff/update/' + $routeParams.id,
          type: 'POST',
          data: {
            avatar: $("input[name='avatar_url']").val(),
            name: $("input[name='nom']").val(),
            lastname: $("input[name='prenom']").val(),
            role: $("input[name='role']").val(),
            bio: $("textarea[name='bio']").val()
          },
          success: function(data) {
            $(".alert").fadeIn();
            $(".alert").removeClass("alert-danger");
            $(".alert").addClass("alert-success");
            $(".alert").html("Your post has been saved successfully");
            $('html, body').animate({
              scrollTop: 0
            }, 500);
            return console.log(data);
          },
          error: (function(_this) {
            return function(jqXHR, textStatus, errorThrown) {
              var errors, msg;
              switch (jqXHR.status) {
                case 400:
                  $(".alert").html("");
                  errors = jqXHR.responseJSON.errors;
                  console.log(errors);
                  msg = [];
                  if (errors.avatar != null) {
                    msg.push(errors.avatar.message);
                  }
                  if (errors.bio != null) {
                    msg.push(errors.bio.message);
                  }
                  if (errors.name != null) {
                    msg.push(errors.name.message);
                  }
                  if (errors.lastname != null) {
                    msg.push(errors.lastname.message);
                  }
                  if (errors.role != null) {
                    msg.push(errors.role.message);
                  }
                  if (msg.length) {
                    if (_.isArray(msg)) {
                      _.each(msg, function(error, key, list) {
                        $(".alert").fadeIn();
                        $(".alert").append("" + error + " </br>");
                        return $(".alert").addClass("alert-danger");
                      });
                    }
                  }
                  return $('html, body').animate({
                    scrollTop: 0
                  }, 300);
              }
            };
          })(this)
        });
      };
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
              status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url;
              img = "<img src='" + public_url + "' width='150' height='150' id='avatar_preview' />";
              $("#preview").html(img);
              $("input[name='avatar_url']").val(public_url);
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
