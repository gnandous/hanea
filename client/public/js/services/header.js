(function() {
  define(['jquery'], function($) {
    var Ticket;
    return Ticket = (function() {
      function Ticket() {
        console.log("hello men");
      }

      Ticket.prototype.go = function() {
        return console.log("hello men");
      };

      return Ticket;

    })();
  });

}).call(this);
