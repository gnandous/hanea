(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("contenus", function($scope, $window, $http) {
      $scope.inputs = {
        location: $("#addcontent").find("#location"),
        title: $("#addcontent").find("#title"),
        subtitle: $("#addcontent").find("#subtitle"),
        content: $("#addcontent").find("#content"),
        publication: $("#addcontent").find("#published")
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
      return $scope.login = function() {
        return $.ajax({
          url: '/api/secure/content',
          type: 'POST',
          data: {
            location: $scope.inputs.location.val(),
            title: $scope.inputs.title.val(),
            subtitle: $scope.inputs.subtitle.val(),
            content: $scope.inputs.content.val(),
            published: $scope.inputs.publication.is(':checked')
          },
          success: function(data) {
            return console.log(data);
          },
          error: (function(_this) {
            return function(jqXHR, textStatus, errorThrown) {
              var errors;
              switch (jqXHR.status) {
                case 400:
                  errors = jqXHR.responseJSON;
                  if (_.isArray(errors)) {
                    return _.each(errors, function(error, key, list) {
                      return _this.inputs[error.field].addClass('parsley-error');
                    });
                  }
              }
            };
          })(this)
        });
      };
    });
  });

}).call(this);
