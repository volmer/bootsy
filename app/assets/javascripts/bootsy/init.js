window.Bootsy = window.Bootsy || {};

Bootsy.init = function() {
  Bootsy.areas = [];

  $('textarea.bootsy_text_area').each(function() {
    var area = new Bootsy.Area($(this));
    area.init();

    Bootsy.areas.push(area);
  });
};

$(Bootsy.init);
