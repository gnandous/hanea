define [
  'jquery'
], ($)->
  Model: ($http, $q)->
    defer = $q.defer()
    $http.get("/api/secure/currentuser").success((data, status)->
      return data
    ).error (data, status)->
      defer.reject(data);
