define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "ArticleMedia", ($scope, $window, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.media = {}
      $scope.media.article_id = $routeParams.id
      $scope.content_state = false
      $scope.success = false
      $scope.article_id = $routeParams


      $("#dropFile").dropzone
        url: "/api/secure/article/#{$routeParams}/media"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.media.content = data

          $("#dropFile").append("<img width='100%' height='400px' src='/uploads/#{data}'/>")
    )()

    $scope.create = ()->
      $.ajax
        #url: "/api/secure/article/update/#{$routeParams.id}"
        url : "/api/secure/article/#{$routeParams.id}/media"
        type: 'POST'
        data: $scope.media
        success: (data)->
          console.log data
          $scope.$apply ()->
            $scope.success = true
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status
