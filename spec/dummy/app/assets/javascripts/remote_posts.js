/* global Bootsy */

$(function(){
  var form = $('#new-remote-post');

  if(form.length > 0) {
    Bootsy.areas['remote-post-area'].editor.on('load', function() {
      form.hide();
    });

    $('a[href="#new-remote-post"]').on('click', function(e){
      form.show();

      e.preventDefault();
    });
  }
});
