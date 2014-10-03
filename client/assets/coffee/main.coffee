require.config
  baseUrl: '/js'
  paths:
    angular:  'plugins/angular/angular.min'
    angularAMD: 'plugins/angular/angularAMD.min'
    angular_route: 'plugins/angular/angular-route'
    ngload: 'plugins/ngload'
    jquery: 'plugins/jquery/jquery.min'
    jquery_cookie: 'plugins/jquery/jquery.cookie.min'
    classie: '../plugins/modal/js/classie'
    modal: '../plugins/modal/js/modalEffects'

  shim:
    jquery:
      exports: '$'
    jquery_cookie: ['jquery']
    angularAMD: ['angular']
    angular_route: ['angular']
    ngload: ['angularAMD']

  deps: ['app']
