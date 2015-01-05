define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "addarticle", ($scope, $window, $http, Model)->
    $scope.user = Model.data
    $scope.model =
      title: ""
      content: ""
      illustration: ""
      published: false
    $scope.init = ()->

      $("#dropFile").dropzone
        url: "/api/secure/article/file/post"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.model.illustration = data
          $("#dropFile").append("<img width='100%' height='400px' src='/uploads/#{data}'/>")

    $scope.init()
    $scope.insertmedia = ->

    $scope.create = ->
      console.log @model.published
      $.ajax
        url: '/api/secure/article'
        type: 'POST'
        data:
          title: @model.title
          content: @model.content
          published: @model.published
          illustration: @model.illustration
        success: (data)->
          $scope.$apply ()->
            $scope.errors = {}
          $(".message .alert").html("<i class='fa fa-check'></i> Your post has been Updated succesfully. Thank You. <strong> <a href='/api/articles'>See content</a></strong>")
          $(".message .alert").fadeIn()
          $('html, body').animate(
            scrollTop: 0
            , 500)
          console.log data
        error: (jqXHR, textStatus, errorThrown)->
          switch jqXHR.status
            when 400
              errors = jqXHR.responseJSON.errors
              $scope.$apply ()->
                $scope.errors = errors
          $('html, body').animate(
            scrollTop: 0
            , 500)
