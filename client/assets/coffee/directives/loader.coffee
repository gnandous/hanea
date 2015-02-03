define [
  'angularAMD'
], (angularAMD)->
  angularAMD.directive 'loader', ()->
    scope:
      loader: "="
      status: '='
    link: ($scope, $elem, attrs)->
      console.log attrs
      console.log $scope.status
