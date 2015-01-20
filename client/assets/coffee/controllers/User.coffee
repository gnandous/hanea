define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "User", ($scope, $window, $http, $routeParams, Model)->
    $scope.user = Model.data

    $scope.update = ()->
      $.ajax
        url: "/api/secure/user/#{$scope.user._id}/update"
        type: 'POST'
        data: $scope.user
        success: (data)->
          $(".message .alert").html("<i class='fa fa-check'></i> User has been Updated succesfully.")
          $(".message .alert").fadeIn()
          $('html, body').animate(
            scrollTop: 0
            , 500)
          console.log data
        error: (jqXHR, textStatus, errorThrown)=>
          console.log jqXHR.status


    s3_upload = () ->
      status_elem = document.getElementById("status")
      preview_elem = document.getElementById("preview")
      file = document.getElementById("files")
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
          img = "<img src='#{public_url}' width='150' height='150' id='avatar_preview' />"
          $("#preview").html(img)
          #$("input[name='avatar']").val(public_url)
          #$("#avatar_url").val(public_url)
          $scope.user.avatar = public_url
          return

        onError: (status) ->
          status_elem.innerHTML = "Upload error: " + status
          return
    (->
      input_element = document.getElementById("files")
      input_element.onchange = s3_upload
      return
    )()
