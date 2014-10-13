define [
  'angularAMD'
], (angularAMD)->
  angularAMD.directive 'contentmenu', ()->
    restrict: 'A'
    templateUrl: "../templates/partials/contentmenu.html"
    controller: ['$scope', '$filter', ($scope, $filter)->
    ]
