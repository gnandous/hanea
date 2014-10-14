define [
  'app'
  'jquery'
  'jquery_cookie'
  'services/authentication'
], (app, $)->
  app.controller 'UserCtrl', ($rootScope, $scope, $window, AuthenticationService, $http)->
    $scope.user =
      username: "gnandou@gmail.com"
      password: "idegnandou"
    $rootScope.user = "MacBookPro"
    $scope.errormsg = "false"
    $scope.message = ""
    $scope.welcome = ""
    $scope.isAuthenticated = false
    $scope.submit = ->
      if $scope.user isnt `undefined`
        AuthenticationService.login($scope.user).success((data, status, headers, config) ->
          $scope.isAuthenticated = true
          $scope.message = "Welcome"
          cookieOptions =
            path: '/'
            expires: 365
          $.cookie 'hanea_session', data._id, cookieOptions
          window.location = '/api/'
        ).error (data, status) ->
          $scope.isAuthenticated = false

          # Handle login errors here
          $scope.error = data
          $scope.errormsg = true
          $scope.welcome = ""
    $scope.logout = ->
      AuthenticationService.logout this
    $scope.callRestricted = ->
      # Should log 'foo'
      $http(
        url: "/api/secure/welcome"
        method: "GET"
      ).success((data, status, headers, config) ->
        $scope.message = $scope.message + data
      ).error (data, status, headers, config) ->
        $scope.message = $scope.message + data
