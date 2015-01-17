(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("contentedit", function($scope, $window, $http, $routeParams, Model) {
      $scope.inputs = {
        location: $("#addcontent").find("#location"),
        title: $("#addcontent").find("#title"),
        subtitle: $("#addcontent").find("#subtitle"),
        content: "",
        publication: $("#addcontent").find("#published")
      };
      $scope.init = function() {
        $scope.user = Model.data;
        return $http.get("/api/secure/content/detail/" + $routeParams.id).success(function(data, status, headers, config) {
          $scope.model = data;
          return $scope.inputs.content = data.content;
        }).error(function(data, status, headers, config) {
          return console.log(status);
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
      $scope.update = function() {
        return $.ajax({
          url: "/api/secure/content/update/" + $routeParams.id,
          type: 'POST',
          data: {
            location: $scope.inputs.location.val(),
            title: $scope.inputs.title.val(),
            subtitle: $scope.inputs.subtitle.val(),
            content: $scope.inputs.content,
            published: $scope.inputs.publication.is(':checked')
          },
          success: function(data) {
            $(".message .alert").html("<i class='fa fa-check'></i> Your post has been Updated succesfully. Thank You. <strong> <a href='/api/articles'>See content</a></strong>");
            $(".message .alert").fadeIn();
            return $('html, body').animate({
              scrollTop: 0
            }, 300);
          },
          error: (function(_this) {
            return function(jqXHR, textStatus, errorThrown) {
              var errors;
              switch (jqXHR.status) {
                case 400:
                  errors = jqXHR.responseJSON;
                  if (_.isArray(errors)) {
                    return _.each(errors, function(error, key, list) {
                      if (!key) {
                        $('html, body').animate({
                          scrollTop: _this.inputs[error.field].offset().top - 30
                        }, 500);
                      }
                      return _this.inputs[error.field].addClass('parsley-error');
                    });
                  }
              }
            };
          })(this)
        });
      };
      return $scope.init();
    });
  });

}).call(this);
