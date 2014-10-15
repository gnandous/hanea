(function() {
  define(['jquery'], function($) {
    return {
      Model: function($http, $q) {
        return $http.get("/api/secure/currentuser").success(function(data, status) {
          return data;
        }).error(function(data, status) {
          return status;
        });
      }
    };
  });

}).call(this);
