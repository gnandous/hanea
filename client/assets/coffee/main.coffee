require.config
  baseUrl: '/js'
  paths:
    angular:  '//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min'
    angularAMD: 'plugins/angular/angularAMD.min'
    angular_route: 'plugins/angular/angular-route'
    ngload: 'plugins/ngload'
    jquery: 'plugins/jquery/jquery.min'
    jquery_cookie: 'plugins/jquery/jquery.cookie.min'

  shim:
    jquery:
      exports: '$'
    jquery_cookie: ['jquery']
    angularAMD: ['angular']
    angular_route: ['angular']
    ngload: ['angularAMD']

  deps: ['app']
