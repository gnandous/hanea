define [
  'angularAMD'
  'features/ressources'
  'angular_route'
  'angular_sanitize'
  'textangular'
  'services/interceptor'
  'directives/header'
  'directives/sidebarright'
], (angularAMD, _Ressources)->
  myApp = angular.module('myApp', ['ngRoute', 'Authorization', 'textAngular'])
  myApp.config ($routeProvider, $locationProvider)->
    $routeProvider.when("/api/login", angularAMD.route
      templateUrl: "/../templates/login.html"
      controller: "UserCtrl"
      controllerUrl: "controllers/login"
    ).when("/api", angularAMD.route
      templateUrl: '/../templates/dashboard.html'
      controller: "dashboard"
      controllerUrl: "controllers/dashboard"
      resolve:
        Model: _Ressources.Model
    ).when("/api/contenu", angularAMD.route
      templateUrl: '/../templates/contenus.html'
      controller: "contenus"
      controllerUrl: "controllers/contenus"
    ).when("/api/contenu/add", angularAMD.route
      templateUrl: '/../templates/addcontent.html'
      controller: "contenus"
      controllerUrl: "controllers/contenus"
    ).when("/api/contenu/all", angularAMD.route
      templateUrl: '/../templates/contentlist.html'
      controller: "contentlist"
      controllerUrl: "controllers/contentlist"
      resolve:
        listOfContents: _Ressources.listOfContents
    ).when("/api/contenu/edit/:id", angularAMD.route
      templateUrl: '/../templates/contentedit.html'
      controller: "contentedit"
      controllerUrl: "controllers/contentedit"
    ).when("/api/staff/add", angularAMD.route
      templateUrl: '/../templates/addstaff.html'
      controller: "addstaff"
      controllerUrl: "controllers/addstaff"
    ).when("/api/staffs", angularAMD.route
      templateUrl: '/../templates/stafflist.html'
      controller: "stafflist"
      controllerUrl: "controllers/stafflist"
    ).when("/api/staff/edit/:id", angularAMD.route
      templateUrl: '/../templates/staffedit.html'
      controller: "staffedit"
      controllerUrl: "controllers/staffedit"
    ).otherwise redirectTo: "/api"
    $locationProvider.html5Mode(true)

  myApp.config ($httpProvider)->
    $httpProvider.interceptors.push('authInterceptor')

  myApp.run ()->
    console.log ("Running app ...")
  angularAMD.bootstrap(myApp)
