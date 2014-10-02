$(document).ready ->
  $('#submit-form').click (event)->
    $('.alert-success').remove()
    $('.alert-danger').remove()
    event.preventDefault()
    $.ajax
      url: '/api/signup'
      type: 'POST'
      data:
        name: $('#inputname').val()
        email: $('#inputemail').val()
        password: $('#inputpassword').val()
        passwordConfirm: $('#inputpasswordConfirm').val()
      success:(data)->
        msg = "<div class='alert alert-success'>#{data}</div>"
        $('.login-logo').before(msg)
      error: (jqXHR, textStatus, errorThrown)->
        if jqXHR.status is 400
          ab = JSON.stringify(jqXHR.responseJSON)
          res = $.parseJSON(ab)
          if res.length > 0
            msg = "<div class='alert alert-danger'>"
            $.each res, (index, item) ->
              msg = msg + "<p>#{res[index].error}</p>"
            msg = msg + "</div>"
            $('.login-logo').before(msg)
