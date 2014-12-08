(function() {
  define(['angularAMD', 'features/ressources', 'angular_route', 'angular_sanitize', 'textangular', 'services/interceptor', 'directives/header', 'directives/sidebarright'], function(angularAMD, _Ressources) {
    var myApp;
    myApp = angular.module('myApp', ['ngRoute', 'Authorization', 'textAngular']);
    myApp.config(function($routeProvider, $locationProvider) {
      $routeProvider.when("/api/login", angularAMD.route({
        templateUrl: "/../templates/login.html",
        controller: "UserCtrl",
        controllerUrl: "controllers/login"
      })).when("/api", angularAMD.route({
        templateUrl: '/../templates/dashboard.html',
        controller: "dashboard",
        controllerUrl: "controllers/dashboard",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/contenu", angularAMD.route({
        templateUrl: '/../templates/contenus.html',
        controller: "contenus",
        controllerUrl: "controllers/contenus",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/contenu/add", angularAMD.route({
        templateUrl: '/../templates/addcontent.html',
        controller: "contenus",
        controllerUrl: "controllers/contenus",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/contenu/all", angularAMD.route({
        templateUrl: '/../templates/contentlist.html',
        controller: "contentlist",
        controllerUrl: "controllers/contentlist",
        resolve: {
          listOfContents: _Ressources.listOfContents,
          Model: _Ressources.Model
        }
      })).when("/api/contenu/edit/:id", angularAMD.route({
        templateUrl: '/../templates/contentedit.html',
        controller: "contentedit",
        controllerUrl: "controllers/contentedit",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/staff/add", angularAMD.route({
        templateUrl: '/../templates/addstaff.html',
        controller: "addstaff",
        controllerUrl: "controllers/addstaff",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/staffs", angularAMD.route({
        templateUrl: '/../templates/stafflist.html',
        controller: "stafflist",
        controllerUrl: "controllers/stafflist",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/staff/edit/:id", angularAMD.route({
        templateUrl: '/../templates/staffedit.html',
        controller: "staffedit",
        controllerUrl: "controllers/staffedit",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/article/add", angularAMD.route({
        templateUrl: '/../templates/addarticle.html',
        controller: "addarticle",
        controllerUrl: "controllers/addarticle",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/articles", angularAMD.route({
        templateUrl: '/../templates/articlelist.html',
        controller: "articlelist",
        controllerUrl: "controllers/articlelist",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/article/update/:id", angularAMD.route({
        templateUrl: '/../templates/articleedit.html',
        controller: "articleedit",
        controllerUrl: "controllers/articleedit",
        resolve: {
          Model: _Ressources.Model
        }
      })).when("/api/user/:id/edit", angularAMD.route({
        templateUrl: '/../templates/useredit.html',
        controller: "User",
        controllerUrl: "controllers/User",
        resolve: {
          Model: _Ressources.Model
        }
      })).otherwise({
        redirectTo: "/api"
      });
      return $locationProvider.html5Mode(true);
    });
    myApp.config(function($httpProvider) {
      return $httpProvider.interceptors.push('authInterceptor');
    });
    myApp.run(function() {
      return console.log("Running app ...");
    });
    return angularAMD.bootstrap(myApp);
  });

}).call(this);
