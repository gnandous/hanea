define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "ArticleParagraphe", ($scope, $window, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.paragraphe = {}
      $scope.paragraphe.article_id = $routeParams.id
      $scope.content_state = false
      $scope.success = false
      $scope.article_id = $routeParams
    )()

    $scope.create = ()->
      unless this.paragraphe.content
        this.content_state = true
        return null
      $.ajax
        #url: "/api/secure/article/update/#{$routeParams.id}"
        url : "/api/secure/article/#{$routeParams.id}/paragraphe"
        type: 'POST'
        data: $scope.paragraphe
        success: (data)->
          $scope.$apply ()->
            $scope.success = true
          console.log data
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status
