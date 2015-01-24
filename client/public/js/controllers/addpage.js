(function() {
  define(['app', '', 'dropzone', 'services/authentication', 'directives/contentmenu'], function(app) {
    return app.controller("AddPage", function($scope, $window, AuthenticationService, $http, $routeParams, $location, Model) {
      $scope.init = (function() {
        $scope.user = Model.data;
        $scope.addpageloader = true;
        $scope.addpageloadertxt = true;
        $scope.media = "";
        $scope.title = "";
        $scope.content = "";
        $scope.options = {
          language: 'en',
          allowedContent: true,
          entities: false
        };
        return $("#dropFile").dropzone({
          url: "/api/secure/page/file",
          thumbnailWidth: 250,
          thumbnailHeight: 150,
          previewTemplate: "<div></div>",
          success: function(file, data) {
            $scope.$apply(function() {
              $scope.media = data.path;
              return $scope.medianame = data.name;
            });
            return $("#dropFile").append("<img width='100%' height='400px' src='/uploads/" + data.name + "'/>");
          }
        });
      })();
      $scope.uploadarea = function() {
        var selected_file;
        selected_file = document.getElementById("attach_file");
        $(".ta-text").focus();
      };
      $scope.loadFileFromDesktop = function(elem) {
        var form, xhr;
        form = new FormData();
        xhr = new XMLHttpRequest();
        form.append('file', elem.files[0]);
        form.append('me', 'souleymane');
        xhr.upload.addEventListener("progress", (function(e) {
          var perc, pourcentage;
          if (e.lengthComputable) {
            perc = Math.round(e.loaded / e.total) * 100;
            pourcentage = perc + "%";
            $(".uploadbar").css("width", pourcentage);
          }
        }), false);
        xhr.onreadystatechange = function() {
          if (xhr.readyState === 4 && xhr.status === 200) {
            console.log(xhr.responseText);
          }
        };
        xhr.open("POST", "/api/secure/article/file/post");
        return xhr.send(form);
      };
      $scope.validate = function() {
        if (!this.content) {
          this.error = true;
          this.message = "Content can not be blank";
          return false;
        }
        if (!this.title) {
          this.error = true;
          this.message = "Title can not be blank";
          return false;
        }
        return true;
      };
      return $scope.create = function() {
        if (!this.validate()) {
          return null;
        }
        $scope.addpageloader = false;
        $scope.addpageloadertxt = false;
        $scope.model = {
          title: $scope.title,
          content: $scope.content,
          media: $scope.media,
          medianame: $scope.medianame
        };
        return $http.post("/api/secure/page", $scope.model).success(function(data, status, headers, config) {
          $scope.resErr = false;
          $location.path("/api/pages");
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
    });
  });

}).call(this);
