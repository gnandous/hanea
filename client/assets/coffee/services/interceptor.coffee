define ['angularAMD','jquery', 'jquery_cookie','angular_route'], (angularAMD, $)->
    #$location.path("/route")
  auth = angular.module 'Authorization', ['ngRoute']
  auth.factory 'authInterceptor', ($rootScope, $q, $window, $location)->
    request: (config)->
      unless $.cookie "hanea_session"
        $location.path("/api/login")
      return config
    response: (response)->
      return response or $q.when(response)
