$(function(){
  var form = $('#new-remote-post');

  if(form.length > 0) {
    form.hide();

    $('a[href="#new-remote-post"]').on('click', function(e){
      form.show();

      e.preventDefault();
    });
  }

  $(document).on('ajax:success', '#new-remote-post', function(evt, data) {
    $('#new-remote-post').hide();
    $(data.post).prependTo('#posts');
  });

  $(document).on('ajax:error', '#new-remote-post', function(evt, data, error) {
    alert(error);
  });
});
