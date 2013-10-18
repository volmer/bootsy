$(function(){
  $(document).on('ajax:success', '#new-remote-post', function(evt, data) {
    $('#new-remote-post').hide();
    $(data.post).prependTo('#posts');
  });

  $(document).on('ajax:error', '#new-remote-post', function(evt, data, error) {
    alert(error);
  });
});
