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
      resolve:
        Model: _Ressources.Model
    ).when("/api/pages", angularAMD.route
      templateUrl: '/../templates/pages.html'
      controller: "Pages"
      controllerUrl: "controllers/pages"
      resolve:
        Model: _Ressources.Model
    ).when("/api/page/:id/edit", angularAMD.route
      templateUrl: '/../templates/editpage.html'
      controller: "EditPage"
      controllerUrl: "controllers/editpage"
      resolve:
        Model: _Ressources.Model
    ).when("/api/page/new", angularAMD.route
      templateUrl: '/../templates/addpage.html'
      controller: "AddPage"
      controllerUrl: "controllers/addpage"
      resolve:
        Model: _Ressources.Model
    ).when("/api/contenu/add", angularAMD.route
      templateUrl: '/../templates/addcontent.html'
      controller: "contenus"
      controllerUrl: "controllers/contenus"
      resolve:
        Model: _Ressources.Model
    ).when("/api/contenu/all", angularAMD.route
      templateUrl: '/../templates/contentlist.html'
      controller: "contentlist"
      controllerUrl: "controllers/contentlist"
      resolve:
        listOfContents: _Ressources.listOfContents
        Model: _Ressources.Model
    ).when("/api/contenu/edit/:id", angularAMD.route
      templateUrl: '/../templates/contentedit.html'
      controller: "contentedit"
      controllerUrl: "controllers/contentedit"
      resolve:
        Model: _Ressources.Model
    ).when("/api/staff/add", angularAMD.route
      templateUrl: '/../templates/addstaff.html'
      controller: "addstaff"
      controllerUrl: "controllers/addstaff"
      resolve:
        Model: _Ressources.Model
    ).when("/api/staffs", angularAMD.route
      templateUrl: '/../templates/stafflist.html'
      controller: "stafflist"
      controllerUrl: "controllers/stafflist"
      resolve:
        Model: _Ressources.Model
    ).when("/api/staff/edit/:id", angularAMD.route
      templateUrl: '/../templates/staffedit.html'
      controller: "staffedit"
      controllerUrl: "controllers/staffedit"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/add", angularAMD.route
      templateUrl: '/../templates/addarticle.html'
      controller: "addarticle"
      controllerUrl: "controllers/addarticle"
      resolve:
        Model: _Ressources.Model
    ).when("/api/articles", angularAMD.route
      templateUrl: '/../templates/articlelist.html'
      controller: "articlelist"
      controllerUrl: "controllers/articlelist"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/update/:id", angularAMD.route
      templateUrl: '/../templates/articleedit.html'
      controller: "articleedit"
      controllerUrl: "controllers/articleedit"
      resolve:
        Model: _Ressources.Model
    ).when("/api/user/:id/edit", angularAMD.route
      templateUrl: '/../templates/useredit.html'
      controller: "User"
      controllerUrl: "controllers/User"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/:id/paragraphe", angularAMD.route
      templateUrl: '/../templates/addparagraphe.html'
      controller: "ArticleParagraphe"
      controllerUrl: "controllers/articleparagraphe"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/:id/media", angularAMD.route
      templateUrl: '/../templates/addmedia.html'
      controller: "ArticleMedia"
      controllerUrl: "controllers/articlemedia"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/:id/overview", angularAMD.route
      templateUrl: '/../templates/overview.html'
      controller: "ArticleView"
      controllerUrl: "controllers/articleview"
      resolve:
        Model: _Ressources.Model
    ).when("/api/paragraphe/:id/edit", angularAMD.route
      templateUrl: '/../templates/editparagraphe.html'
      controller: "EditParagraphe"
      controllerUrl: "controllers/editparagraphe"
      resolve:
        Model: _Ressources.Model
    ).when("/api/article/:id/media/:media_id/edit", angularAMD.route
      templateUrl: '/../templates/editmedia.html'
      controller: "EditMedia"
      controllerUrl: "controllers/editmedia"
      resolve:
        Model: _Ressources.Model
    ).when("/api/ticket", angularAMD.route
      templateUrl: '/../templates/ticket.html'
      controller: "Ticket"
      controllerUrl: "controllers/ticket"
      resolve:
        Model: _Ressources.Model
    ).when("/api/letter", angularAMD.route
      templateUrl: '/../templates/letter.html'
      controller: "Letter"
      controllerUrl: "controllers/letter"
      resolve:
        Model: _Ressources.Model
    ).otherwise redirectTo: "/api"
    $locationProvider.html5Mode(true)

  myApp.config ($httpProvider)->
    $httpProvider.interceptors.push('authInterceptor')

  myApp.run ($rootScope)->
    $rootScope.$on "$routeChangeStart", (e, curr, prev)->
      ## show loading page
      $rootScope.loadingView = true  if curr.$$route and curr.$$route.resolve
    $rootScope.$on "$routeChangeSuccess", (e, curr, prev)->
      ## hide loading page
      $rootScope.loadingView = false


    console.log ("Running app ...")
  angularAMD.bootstrap(myApp)
