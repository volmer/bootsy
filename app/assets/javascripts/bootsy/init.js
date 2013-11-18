window.Bootsy = window.Bootsy || {};

Bootsy.init = function() {
  Bootsy.areas = {};

  $('textarea.bootsy_text_area').each(function(index) {
    var area = new Bootsy.Area($(this));
    var areaIdx = $(this).attr('id') || index;

    area.init();

    Bootsy.areas[areaIdx] = area;
  });
};

$(Bootsy.init);
