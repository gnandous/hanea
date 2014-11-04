define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "addstaff", ($scope, $window, $http, $routeParams)->
    console.log ("add staff controller ...")
    s3_upload = () ->
      status_elem = document.getElementById("status")
      url_elem = document.getElementById("avatar_url")
      preview_elem = document.getElementById("preview")
      s3upload = new S3Upload
        file_dom_selector: "files"
        s3_sign_put_url: "/api/secure/sign_s3"
        onProgress: (percent, message) ->
          status_elem.innerHTML = "Upload progress: " + percent + "% " + message
          return

        onFinishS3Put: (public_url) ->
          status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url
          url_elem.value = public_url
          preview_elem.innerHTML = "<img src=\"" + public_url + "\" style=\"width:300px;\" />"
          return

        onError: (status) ->
          status_elem.innerHTML = "Upload error: " + status
          return
    (->
      input_element = document.getElementById("files")
      input_element.onchange = s3_upload
      return
    )()
