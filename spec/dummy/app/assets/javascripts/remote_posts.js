$(function(){
  var form = $('#new-remote-post');

  if(form.length > 0) {

    Bootsy.areas[0].editor.on('load', function(){
      form.hide();
    });

    $('a[href="#new-remote-post"]').on('click', function(){
      form.show();
    });
  }
});
