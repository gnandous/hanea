(function() {
  define(['jquery', 'underscore', 'text!/../../templates/header.html'], function($, _, header) {
    var headerView;
    return headerView = (function() {
      headerView.prototype.el = '.navbar .container';

      headerView.prototype.template2 = _.template("");

      headerView.prototype.template = _.template(header);

      function headerView() {}

      headerView.prototype.render = function() {
        if (!$.cookie("hanea_session")) {
          return $(this.el).html(this.template2);
        } else {
          return $(this.el).html(this.template);
        }
      };

      return headerView;

    })();
  });

}).call(this);
