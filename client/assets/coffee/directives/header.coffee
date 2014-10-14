define [
  'angularAMD'
], (angularAMD)->
  angularAMD.directive 'header', ()->
    restrict: 'A'
    templateUrl: "/../templates/partials/header.html"
    controller: ['$scope', '$filter', ($scope, $filter)->
    ]
