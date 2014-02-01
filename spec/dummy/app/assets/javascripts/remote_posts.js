$(function(){
  var form = $('#new-remote-post');

  if(form.length > 0) {
    form.hide();

    $('a[href="#new-remote-post"]').on('click', function(e){
      form.toggle();

      e.preventDefault();
    });
  }
});
