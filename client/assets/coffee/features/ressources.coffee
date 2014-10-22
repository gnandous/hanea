define [
  'jquery'
], ($)->
  Model: ($http, $q)->
    $http.get("/api/secure/currentuser").success((data, status)->
      return data
    ).error (data, status)->
      return status

  listOfContents: ($http, $q)->
    $http.get("/api/secure/content/all").success((data, status)->
      return data
    ).error (data, status)->
      return status
