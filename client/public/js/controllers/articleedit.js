(function() {
  define(['app', 'jquery', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("articleedit", function($scope, $window, $http, $routeParams, Model) {
      $scope.user = Model.data;
      $scope.init = function() {
        return $http.get("/api/secure/article/" + $routeParams.id).success(function(data, status, headers, config) {
          $scope.model = data;
          return console.log(data);
        }).error(function(data, status, headers, config) {
          return console.log(data);
        });
      };
      $scope.update = function() {
        return $.ajax({
          url: "/api/secure/article/update/" + $routeParams.id,
          type: 'POST',
          data: this.model,
          success: function(data) {
            $scope.$apply(function() {
              return $scope.errors = {};
            });
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
                  errors = jqXHR.responseJSON.errors;
                  $scope.$apply(function() {
                    return $scope.errors = errors;
                  });
              }
              return $('html, body').animate({
                scrollTop: 0
              }, 500);
            };
          })(this)
        });
      };
      return $scope.init();
    });
  });

}).call(this);
