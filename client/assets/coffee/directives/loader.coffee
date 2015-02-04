define [
  'angularAMD'
], (angularAMD)->
  angularAMD.directive 'loader', ()->
    restrict: 'E'
    scope:
      progress: '=progressbar'
    link: ($scope, $el, attrs)->
      console.log $el.children().find(".uploadbar")
    template: "<div class='uploadbar' style='width:{{progress}}'></div>"
