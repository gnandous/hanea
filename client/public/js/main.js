(function() {
  require.config({
    baseUrl: '/js',
    paths: {
      dropzone: 'plugins/dropzone/dropzone',
      angular: 'plugins/angular/angular.min',
      angularAMD: 'plugins/angular/angularAMD.min',
      angular_route: 'plugins/angular/angular-route',
      angular_sanitize: 'plugins/angular/angular-sanitize.min',
      textangular: 'plugins/angular/textAngular.min',
      ngload: 'plugins/ngload',
      jquery: 'plugins/jquery/jquery.min',
      jquery_cookie: 'plugins/jquery/jquery.cookie.min',
      underscore: 'plugins/underscore/underscore',
      text: 'plugins/require/text.min',
      chart: 'plugins/chart/Chart.min'
    },
    shim: {
      jquery: {
        exports: '$'
      },
      foggy: {
        deps: ['jquery']
      },
      jqtinymce: {
        deps: ['jquery']
      },
      tinymce: {
        exports: 'tinymce'
      },
      jquery_cookie: ['jquery'],
      angularAMD: ['angular'],
      angular_sanitize: ['angular'],
      textangular: ['angular'],
      angular_route: ['angular'],
      ngload: ['angularAMD'],
      dropzone: ['jquery']
    },
    deps: ['app']
  });

}).call(this);
