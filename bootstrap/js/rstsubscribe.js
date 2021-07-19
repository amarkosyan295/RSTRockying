

/* attach a submit handler to the form */
$("#subscribemodalform").submit(function (event) {

    /* stop form from submitting normally */
    event.preventDefault();

    /* get some values from elements on the page: */
    var $form = $(this),
        mn = $form.find('input[name="membername"]').val(),
        se = $form.find('input[name="subcribeemail"]').val(),
        url = $form.attr('action');

    /* Send the data using post and put the results in a div */
    $.post(url, { membername: mn, subcribeemail: se, rt: 'ajax' },
      function (data) {
          $("#subscribemodalresult").empty().append(data);
          $("#subscribeboxclosebtn").css('display', 'block');
      }
    );
});

  $("#subscribeboxform").submit(function (event) {
      /* stop form from submitting normally */
      event.preventDefault();

      /* get some values from elements on the page: */
      var $form = $(this),
        se = $form.find('input[name="subcribeemail"]').val(),
        url = $form.attr('action');

      /* Send the data using post and put the results in a div */
      $.post(url, { subcribeemail: se, rt: 'ajax' },
      function (data) {
          $("#subscribeboxresult").empty().append(data);
          $("#subcribeemail").val("");
          
      }
    );
  });