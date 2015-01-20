define [
  'app'
  'dropzone'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "EditPage", ($scope, $window, $location, AuthenticationService, $http, $routeParams, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.error = false
      $scope.modeloldimg = ""
      $scope.addpageloader = true
      $scope.addpageloadertxt = true
      $scope.media = ""
      $http.get("/api/secure/page/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.modeloldimg = data.media
        $scope.model = data
      ).error (data, status, headers, config) ->
        console.log status


      $("#dropFile").dropzone
        url: "/api/secure/page/file"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.model.to_remove = $scope.model.media
            $scope.media = data.path
            $scope.model.media = data.path
            $scope.medianame = data.name
            $scope.model.medianame = data.name
          $("#dropFile").html("<img width='100%' height='400px' src='/uploads/#{data.name}'/>")
    )()

    $scope.validate = ()->
      unless @model.content
        this.error = true
        this.message = "Content can not be blank"
        return false
      unless @model.title
        this.error = true
        this.message = "Title can not be blank"
        return false

      return true
    $scope.update = ()->
      unless @validate()
        return null
      if $scope.media_to_remove
        $scope.model.to_remove = $scope.modeloldimg
      $http.post("/api/secure/page/#{$routeParams.id}", $scope.model).success((data, status, headers, config) ->
        $scope.resErr = false
        console.log data
        $location.path "/api/pages"
        return
      ).error (data, status, headers, config) ->
        console.log status
