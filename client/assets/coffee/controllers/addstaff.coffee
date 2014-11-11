define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "addstaff", ($scope, $window, $http, $routeParams)->

    $scope.change = (event)->
      if $(document.activeElement).val()
        $(document.activeElement).removeClass('parsley-error')
        return true
      else
        $(document.activeElement).addClass('parsley-error')
        return false
    s3_upload = () ->
      status_elem = document.getElementById("status")
      preview_elem = document.getElementById("preview")
      s3upload = new S3Upload
        file_dom_selector: "files"
        s3_sign_put_url: "/api/secure/sign_s3"
        s3_object_name: "user01-img"
        onProgress: (percent, message) ->
          status_elem.innerHTML = "Upload progress: " + percent + "% " + message
          $(".progress").css('display', 'block');
          $("div[role='progressbar']").css('width', "#{percent}%")
          return

        onFinishS3Put: (public_url) =>
          status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url
          img = "<img src='#{public_url}' width='150' height='150' id='avatar_preview' />"
          $("#preview").html(img)
          return

        onError: (status) ->
          status_elem.innerHTML = "Upload error: " + status
          return
    (->
      input_element = document.getElementById("files")
      input_element.onchange = s3_upload
      return
    )()
