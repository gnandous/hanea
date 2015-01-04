define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "ArticleView", ($scope, $window, $http, $routeParams, Model)->
    console.log("articleview")
