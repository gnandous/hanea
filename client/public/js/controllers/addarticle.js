(function() {
  define(['app', 'jquery', 'dropzone', 'underscore', 'directives/contentmenu'], function(app, $, _) {
    return app.controller("addarticle", function($scope, $window, $http, Model) {
      $scope.user = Model.data;
      $scope.Category = {};
      $scope.Category.list = {};
      $scope.model = {
        title: "",
        content: "",
        illustration: "",
        published: false,
        categories: []
      };
      $scope.addCategory = function(index) {
        var name;
        name = this.Category.list[index].name;
        if (this.model.categories.indexOf(name) === -1) {
          return this.model.categories.push(name);
        } else {
          return this.removeCategoryFromModel(name);
        }
      };
      $scope.removeCategoryFromModel = function(name) {
        return this.model.categories.splice(this.model.categories.indexOf(name), 1);
      };
      $scope.loadCategories = function() {
        return $http.get("/api/secure/categories").success(function(data, status, headers, config) {
          return $scope.Category.list = data;
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      $scope.init = function() {
        this.loadCategories();
        return $("#dropFile").dropzone({
          url: "/api/secure/article/file/post",
          thumbnailWidth: 250,
          thumbnailHeight: 150,
          previewTemplate: "<div></div>",
          success: function(file, data) {
            $scope.$apply(function() {
              return $scope.model.illustration = data;
            });
            return $("#dropFile").append("<img width='100%' height='400px' src='/uploads/" + data + "'/>");
          }
        });
      };
      $scope.init();
      $scope.createCategory = function(Category) {
        if (!this.Category["new"]) {
          return;
        }
        return $http.post("/api/secure/category", $scope.Category["new"]).success(function(data, status, headers, config) {
          return $scope.Category.list.push(data);
        }).error(function(data, status, headers, config) {
          return console.log(status);
        });
      };
      $scope.insertmedia = function() {};
      return $scope.create = function() {
        console.log(this.model.published);
        return $.ajax({
          url: '/api/secure/article',
          type: 'POST',
          data: {
            title: this.model.title,
            content: this.model.content,
            published: this.model.published,
            illustration: this.model.illustration
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
