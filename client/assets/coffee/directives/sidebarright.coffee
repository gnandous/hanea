define [
  'angularAMD'
], (angularAMD)->
  angularAMD.directive 'sidebarright', ()->
    restrict: 'A'
    templateUrl: "/../templates/partials/sidebarright.html"
    controller: ['$scope', '$filter', ($scope, $filter)->
    ]
