window.Bootsy = window.Bootsy || {};

window.Bootsy.locales = {
  en: {
    image: {
      empty: 'There are currently no uploaded images.',
      refresh: 'Refresh'
    },
    alertUnsaved: 'You have unsaved changes.',
    error: 'Something went very wrong. Please try again later.'
  }
};

/**
 * Extra translations for bootstrap-wysihtml5
 */
(function($){
  $.fn.wysihtml5.locale = $.extend(true, $.fn.wysihtml5.locale, Bootsy.locales);
}(jQuery));
