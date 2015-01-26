define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "addarticle", ($scope, $window, $http, Model)->
    $scope.user = Model.data
    $scope.Category = {}
    $scope.Category.list = {}
    $scope.model =
      title: ""
      content: ""
      resum: ""
      published: false
      categories: []

    $scope.addCategory = (index) ->
      name = @Category.list[index].name
      if @model.categories.indexOf(name) is -1
        @model.categories.push name
      else
        @removeCategoryFromModel name
    $scope.removeCategoryFromModel = (name) ->
      @model.categories.splice @model.categories.indexOf(name), 1

    $scope.loadCategories = ->
      $http.get("/api/secure/categories").success((data, status, headers, config) ->
        $scope.Category.list = data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.init = ()->

      @loadCategories()


      $("#dropFile").dropzone
        url: "/api/secure/article/file/post"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.model.illustration = data.path
            $scope.model.illustrationname = data.name
          $("#dropFile").append("<img width='100%' height='400px' src='/uploads/#{data.name}'/>")

    $scope.init()

    $scope.createCategory = (Category)->
      unless @Category.new
        return
      $http.post("/api/secure/category", $scope.Category.new).success((data, status, headers, config) ->
        $scope.Category.list.push data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.insertmedia = ->

    $scope.create = ->
      $.ajax
        url: '/api/secure/article'
        type: 'POST'
        data:
          title: @model.title
          resum: @model.resum
          content: @model.content
          published: @model.published
          illustration: @model.illustration
          illustrationname: @model.illustrationname
          categories: JSON.stringify @model.categories
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
