define [
  'app'
  'jquery'
  'dropzone'
  'underscore'
  'directives/contentmenu'
  'directives/loader'
], (app, $, _)->
  app.controller "Letter", ($scope, $window, $http, Model)->
    $scope.init = (->
      $scope.user = Model.data
      $scope.content_state = false
      $scope.lightbox = false
      $scope.stat = "Not upload yet"
      $scope.progress = "0%;"
    )()

    $scope.Ctrl =
      setFile: ()->
        $("#uplaoderCtrl").click()
        return
      loadFileFromDesktop: (elem)->
        haupload = new HAUpload
          name: "test"
          url: '/api/secure/article/file/post'
          file_dom_selector: "uplaoderCtrl"
          onProgress: (percent, message)->
            $scope.$apply ()->
              $scope.progress = percent + "%;"
          onFinishPut: (publicUrl)->
            console.log publicUrl

