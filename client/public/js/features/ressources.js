(function() {
  define(['jquery'], function($) {
    return {
      Model: function($http, $q) {
        return $http.get("/api/secure/currentuser").success(function(data, status) {
          return data;
        }).error(function(data, status) {
          return status;
        });
      },
      listOfContents: function($http, $q) {
        return $http.get("/api/secure/content/all").success(function(data, status) {
          return data;
        }).error(function(data, status) {
          return status;
        });
      }
    };
  });

}).call(this);
