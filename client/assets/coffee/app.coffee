define [
  'angularAMD',
  'angular_route',
  'services/interceptor',
  'directives/header'
  'directives/sidebarright'
], (angularAMD, headerView)->
  myApp = angular.module('myApp', ['ngRoute', 'Authorization'])

  myApp.config ($routeProvider, $locationProvider)->
    $routeProvider.when("/api/login", angularAMD.route
      templateUrl: "../templates/login.html"
      controller: "UserCtrl"
      controllerUrl: "controllers/login"
    ).when("/api", angularAMD.route
      templateUrl: '../templates/dashboard.html'
      controller: "dashboard"
      controllerUrl: "controllers/dashboard"
    ).otherwise redirectTo: "/api"
    $locationProvider.html5Mode(true)

  myApp.config ($httpProvider)->
    $httpProvider.interceptors.push('authInterceptor')

  myApp.run ()->
    console.log ("Running app ...")
  angularAMD.bootstrap(myApp)
