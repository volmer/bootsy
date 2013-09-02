window.Bootsy = window.Bootsy || {};

Bootsy.init = function() {
  Bootsy.areas = [];

  $('textarea.bootsy_text_area').each(function() {
    Bootsy.areas.push(new Bootsy.Area($(this)));
  });
};

$(Bootsy.init);
