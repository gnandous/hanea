define [
  'app'
  'services/authentication'
], (app) ->
  app.controller "EditParagraphe", ($scope, $window, AuthenticationService, $http, $routeParams, Model)->
    $scope.user = Model.data
    $http.get("/api/secure/paragraphe/#{$routeParams.id}").success((data, status, headers, config) ->
        $scope.paragraphe = data
      ).error (data, status, headers, config) ->
        console.log status

    $scope.update = ()->
      unless this.paragraphe.content
        this.content_state = true
        return null
      $.ajax
        #url: "/api/secure/article/update/#{$routeParams.id}"
        url : "/api/secure/paragraphe/#{$routeParams.id}"
        type: 'POST'
        data: $scope.paragraphe
        success: (data)->
          $scope.$apply ()->
            $scope.success = true
          console.log data
        error: (jqXHR, textStatus, errorThrown)->
          console.log jqXHR.status
