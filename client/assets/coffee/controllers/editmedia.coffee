define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "EditMedia", ($scope, $window, $http, $routeParams, Model)->
    $scope.init = (->
      $http.get("/api/secure/media/#{$routeParams.media_id}").success((data, status, headers, config) ->
        $scope.media_to_edit = data
      ).error (data, status, headers, config) ->
        console.log status

      $scope.user = Model.data
      $scope.media = {}
      $scope.media.article_id = $routeParams.id
      $scope.content_state = false
      $scope.success = false
      $scope.article_id = $routeParams


      $("#dropFile").dropzone
        url: "/api/secure/article/#{$routeParams.media_id}/media"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.media.content = data.path
            $scope.media.medianame = data.file.name
          $("#dropFile").append("<img width='100%' height='400px' src='/uploads/#{data.file.name}'/>")
    )()

    $scope.update = ()->
      $.ajax
        #url: "/api/secure/article/update/#{$routeParams.id}"
        url : "/api/secure/media/#{$routeParams.media_id}"
        type: 'POST'
        data: $scope.media
        success: (data)->
          $scope.$apply ()->
            $scope.success = true
            $scope.media_to_edit = data
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status
