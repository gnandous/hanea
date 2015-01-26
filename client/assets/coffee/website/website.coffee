$(document).ready ->
  wall = new freewall "#container"

  wall.reset
    selector: '.articles-list-item'
    animate: true
    cellW: 300
    cellH: 'auto'
    onResize: ()->
      wall.fitWidth()
  wall.fitWidth()
