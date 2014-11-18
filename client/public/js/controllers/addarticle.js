(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("addarticle", function($scope, $window, $http) {
      $scope.model = {
        title: "",
        content: "",
        published: false
      };
      return $scope.create = function() {
        console.log(this.model.published);
        return $.ajax({
          url: '/api/secure/article',
          type: 'POST',
          data: {
            title: this.model.title,
            content: this.model.content,
            published: this.model.published
          },
          success: function(data) {
            $scope.$apply(function() {
              return $scope.errors = {};
            });
            $(".message .alert").html("<i class='fa fa-check'></i> Your post has been Updated succesfully. Thank You. <strong> <a href='/api/articles'>See content</a></strong>");
            $(".message .alert").fadeIn();
            $('html, body').animate({
              scrollTop: 0
            }, 500);
            return console.log(data);
          },
          error: function(jqXHR, textStatus, errorThrown) {
            var errors;
            switch (jqXHR.status) {
              case 400:
                errors = jqXHR.responseJSON.errors;
                $scope.$apply(function() {
                  return $scope.errors = errors;
                });
            }
            return $('html, body').animate({
              scrollTop: 0
            }, 500);
          }
        });
      };
    });
  });

}).call(this);
