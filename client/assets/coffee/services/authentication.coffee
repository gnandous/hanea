define ['app'], (app)->
  app.factory "AuthenticationService", ($window, $http) ->
    login: (user) ->
      $http.post "/api/login", user
    logout: ($scope) ->
      $.removeCookie('hanea_session', { path: '/' });
      $scope.welcome = ""
      $scope.message = ""
      $scope.isAuthenticated = false
      delete $window.sessionStorage.token
