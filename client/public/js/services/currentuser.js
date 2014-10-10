(function() {
  require(['app'], function(app) {
    return app.factory("currentUser", function($window, $http) {
      return {
        getuser: function() {
          return $http.get("/api/secure/current");
        }
      };
    });
  });

}).call(this);
