window.Bootsy = window.Bootsy || {};

$(function(){
  Bootsy.areas = [];
  $('textarea.bootsy_text_area').each(function() {
    Bootsy.areas.push(new Bootsy.Area($(this)));
  });
});
