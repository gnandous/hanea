(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _, tinymce, jqtinymce) {
    return app.controller("contenus", function($scope, $window, $http, Model) {
      $scope.user = Model.data;
      $scope.content = "";
      $scope.disabled = false;
      $scope.inputs = {
        location: $("#addcontent").find("#location"),
        title: $("#addcontent").find("#title"),
        subtitle: $("#addcontent").find("#subtitle"),
        content: $("#addcontent").find("#content").find('.form-control'),
        publication: $("#addcontent").find("#published")
      };
      $scope.init = function() {};
      $scope.change = function(event) {
        if ($(document.activeElement).val()) {
          $(document.activeElement).removeClass('parsley-error');
          return true;
        } else {
          $(document.activeElement).addClass('parsley-error');
          return false;
        }
      };
      $scope.create = function() {
        return $.ajax({
          url: '/api/secure/content',
          type: 'POST',
          data: {
            location: $scope.inputs.location.val(),
            title: $scope.inputs.title.val(),
            subtitle: $scope.inputs.subtitle.val(),
            content: $scope.content,
            published: $scope.inputs.publication.is(':checked')
          },
          success: function(data) {
            $(".message .alert").html("<i class='fa fa-check'></i> Your post has been added succesfully. Thank You. <strong> <a href='/api/contenu/all'>See content</a></strong>");
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
