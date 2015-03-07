/* global Bootsy */
window.Bootsy = window.Bootsy || {};

// Public: Intialize Bootsy editors in all visible `textarea`
//         elements that has the `bootsy_text_area` class.
Bootsy.init = function() {
  if (!Bootsy.areas) {
    Bootsy.areas = {};
  }

  $('textarea.bootsy_text_area').each(function(index) {
    if (!$(this).data('bootsy-initialized')) {
      var area = new Bootsy.Area($(this));
      var areaIdx = $(this).attr('id') || index;

      /* There's always people who let elements share ids */
      if(Bootsy.areas[areaIdx] !== undefined) {
        areaIdx = $(this).attr('id') + index;
      }

      area.init();

      Bootsy.areas[areaIdx] = area;
    }
  });
};

/* Initialize Bootsy on document load */
$(function() {
  $(window).load(function() {
    Bootsy.init();

    /* Reload Bootsy on page load when using Turbolinks. */
    if (window.Turbolinks) {
      $(document).on('page:load', Bootsy.init);
    }
  });
});
