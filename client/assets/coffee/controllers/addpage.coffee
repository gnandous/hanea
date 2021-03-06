define [
  'app'
  ''
  'dropzone'
  'services/authentication'
  'directives/contentmenu'
], (app) ->
  app.controller "AddPage", ($scope, $window, AuthenticationService, $http, $routeParams,$location, Model)->
    $scope.init = (->



      $scope.user = Model.data
      $scope.addpageloader = true
      $scope.addpageloadertxt = true
      $scope.media = ""
      $scope.title = ""
      $scope.content = ""
      $scope.options =
        language: 'en',
        allowedContent: true,
        entities: false


      $("#dropFile").dropzone
        url: "/api/secure/page/file"
        thumbnailWidth:250
        thumbnailHeight:150
        previewTemplate: "<div></div>"
        success:(file, data)->
          $scope.$apply ()->
            $scope.media = data.path
            $scope.medianame = data.name
          $("#dropFile").append("<img width='100%' height='400px' src='/uploads/#{data.name}'/>")

    )()
    $scope.uploadarea = (event)->


    $scope.loadFileFromDesktop = (elem)->
      form = new FormData()
      xhr = new XMLHttpRequest()
      form.append('file', elem.files[0])
      form.append('me', 'souleymane')
      xhr.upload.addEventListener "progress", ((e) ->
        if e.lengthComputable
          perc = Math.round(e.loaded / e.total) * 100
          pourcentage = perc + "%"
          $(".uploadbar").css "width", pourcentage
        return
      ), false
      xhr.onreadystatechange = ->
        if xhr.readyState is 4 and xhr.status is 200
          console.log xhr.responseText
        return
      xhr.open("POST", "/api/secure/article/file/post")
      xhr.send(form)

    ## validate function ()
    $scope.validate = ()->
      unless @content
        this.error = true
        this.message = "Content can not be blank"
        return false
      unless @title
        this.error = true
        this.message = "Title can not be blank"
        return false

      return true

    $scope.create = ()->
      unless @validate()
        return null
      $scope.addpageloader = false
      $scope.addpageloadertxt = false
      $scope.model =
        title: $scope.title
        content: $scope.content
        media: $scope.media
        medianame: $scope.medianame
      $http.post("/api/secure/page", $scope.model).success((data, status, headers, config) ->
        $scope.resErr = false
        $location.path "/api/pages"
        return
      ).error (data, status, headers, config) ->
        console.log status

