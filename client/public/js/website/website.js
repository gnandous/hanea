(function() {
  $(document).ready(function() {
    var wall;
    wall = new freewall("#container");
    wall.reset({
      selector: '.articles-list-item',
      animate: true,
      cellW: 300,
      cellH: 'auto',
      onResize: function() {
        return wall.fitWidth();
      }
    });
    return wall.fitWidth();
  });

}).call(this);
