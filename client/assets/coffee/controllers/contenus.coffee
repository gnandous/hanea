define [
  'app'
  'jquery'
  'underscore'
  'chart'
  'directives/contentmenu'
], (app, $, _, chart, tinymce, jqtinymce)->
  app.controller "contenus", ($scope, $window, $http, Model)->
    $scope.user = Model.data
    $scope.content = ""
    $scope.disabled = false
    $scope.inputs =
      location : $("#addcontent").find("#location")
      title : $("#addcontent").find("#title")
      subtitle : $("#addcontent").find("#subtitle")
      content : $("#addcontent").find("#content").find('.form-control')
      publication : $("#addcontent").find("#published")
    $scope.data =
      labels: ["January", "February", "March", "April", "May", "June", "July"]
      datasets: [
        {
          label: "My First dataset"
          fillColor: "rgba(220,220,220,0.2)"
          strokeColor: "rgba(220,220,220,1)"
          pointColor: "rgba(220,220,220,1)"
          pointStrokeColor: "#fff"
          pointHighlightFill: "#fff"
          pointHighlightStroke: "rgba(220,220,220,1)"
          data: [65, 59, 80, 81, 56, 55, 40]
        }
        {
          label: "My Second dataset"
          fillColor: "rgba(151,187,205,0.2)"
          strokeColor: "rgba(151,187,205,1)"
          pointColor: "rgba(151,187,205,1)"
          pointStrokeColor: "#fff"
          pointHighlightFill: "#fff"
          pointHighlightStroke: "rgba(151,187,205,1)"
          data: [28, 48, 40, 19, 86, 27, 90]
        }
      ]

    $scope.init = ()->
      if document.getElementById("DashboardChart")
        ctx = document.getElementById("DashboardChart").getContext("2d")
        myNewChart = new Chart(ctx).Line(@data)
    $scope.change = (event)->
      if $(document.activeElement).val()
        $(document.activeElement).removeClass('parsley-error')
        return true
      else
        $(document.activeElement).addClass('parsley-error')
        return false
    $scope.create = ()->
      $.ajax
        url: '/api/secure/content'
        type: 'POST'
        data:
          location : $scope.inputs.location.val()
          title : $scope.inputs.title.val()
          subtitle : $scope.inputs.subtitle.val()
          content : $scope.content
          published : $scope.inputs.publication.is(':checked')
        success: (data)->
          $(".message .alert").html("<i class='fa fa-check'></i> Your post has been added succesfully. Thank You. <strong> <a href='/api/contenu/all'>See content</a></strong>")
          $(".message .alert").fadeIn()
          $('html, body').animate(
            scrollTop: 0
          , 300)
        error: (jqXHR, textStatus, errorThrown)=>
          switch jqXHR.status
            when 400
              errors = jqXHR.responseJSON
              if _.isArray errors
                _.each errors, (error, key, list)=>
                  unless key
                    $('html, body').animate(
                      scrollTop: @inputs[error.field].offset().top - 30
                    , 500)
                  @inputs[error.field].addClass('parsley-error')
    #call init function
    $scope.init()
