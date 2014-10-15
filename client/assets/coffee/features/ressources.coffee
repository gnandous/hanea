define [
  'jquery'
], ($)->
  Model: ($http, $q)->
    $http.get("/api/secure/currentuser").success((data, status)->
      return data
    ).error (data, status)->
      return status
