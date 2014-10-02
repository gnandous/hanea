(function() {
  $(document).ready(function() {
    return $('#submit-form').click(function(event) {
      $('.alert-success').remove();
      $('.alert-danger').remove();
      event.preventDefault();
      return $.ajax({
        url: '/api/signup',
        type: 'POST',
        data: {
          name: $('#inputname').val(),
          email: $('#inputemail').val(),
          password: $('#inputpassword').val(),
          passwordConfirm: $('#inputpasswordConfirm').val()
        },
        success: function(data) {
          var msg;
          msg = "<div class='alert alert-success'>" + data + "</div>";
          return $('.login-logo').before(msg);
        },
        error: function(jqXHR, textStatus, errorThrown) {
          var ab, msg, res;
          if (jqXHR.status === 400) {
            ab = JSON.stringify(jqXHR.responseJSON);
            res = $.parseJSON(ab);
            if (res.length > 0) {
              msg = "<div class='alert alert-danger'>";
              $.each(res, function(index, item) {
                return msg = msg + ("<p>" + res[index].error + "</p>");
              });
              msg = msg + "</div>";
              return $('.login-logo').before(msg);
            }
          }
        }
      });
    });
  });

}).call(this);
