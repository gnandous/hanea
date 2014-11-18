define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "addarticle", ($scope, $window, $http)->
    $scope.model =
      title: ""
      content: ""
      published: false
    $scope.create = ->
      console.log @model.published
      $.ajax
        url: '/api/secure/article'
        type: 'POST'
        data:
          title: @model.title
          content: @model.content
          published: @model.published
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
