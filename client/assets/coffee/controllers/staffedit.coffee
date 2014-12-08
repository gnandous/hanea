define [
  'app'
  'jquery'
  'underscore'
  'directives/contentmenu'
], (app, $, _)->
  app.controller "staffedit", ($scope, $window, $http, $routeParams, Model)->
    $scope.init = ()->
      $scope.user = Model.data
      $http.get("/api/secure/staff/show/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.model = data
        console.log data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.init()

    $scope.update = ()->
      $.ajax
        url: '/api/secure/staff/update/' + $routeParams.id
        type: 'POST'
        data:
          avatar: $("input[name='avatar_url']").val()
          name: $("input[name='nom']").val()
          lastname: $("input[name='prenom']").val()
          role: $("input[name='role']").val()
          bio: $("textarea[name='bio']").val()
        success: (data)->
          $(".alert").fadeIn()
          $(".alert").removeClass("alert-danger")
          $(".alert").addClass("alert-success")
          $(".alert").html("Your post has been saved successfully")
          $('html, body').animate(
                scrollTop: 0
              , 500)
          console.log data
        error: (jqXHR, textStatus, errorThrown)=>
          switch jqXHR.status
            when 400
              $(".alert").html("")
              errors = jqXHR.responseJSON.errors
              console.log errors
              msg = []
              if errors.avatar?
                msg.push (errors.avatar.message)
              if errors.bio?
                 msg.push(errors.bio.message)
              if errors.name?
                 msg.push(errors.name.message)
              if errors.lastname?
                msg.push(errors.lastname.message)
              if errors.role?
                msg.push(errors.role.message)
              if msg.length
                if _.isArray msg
                  _.each msg, (error, key, list)=>
                    $(".alert").fadeIn()
                    $(".alert").append("#{error} </br>")
                    $(".alert").addClass("alert-danger")
              $('html, body').animate(
                scrollTop: 0
              , 300)

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
          status_elem.innerHTML = "Upload completed. Uploaded to: " + public_url
          img = "<img src='#{public_url}' width='150' height='150' id='avatar_preview' />"
          $("#preview").html(img)
          $("input[name='avatar_url']").val(public_url)
          return

        onError: (status) ->
          status_elem.innerHTML = "Upload error: " + status
          return
    (->
      input_element = document.getElementById("files")
      input_element.onchange = s3_upload
      return
    )()
