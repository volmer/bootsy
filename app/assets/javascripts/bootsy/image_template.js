window.Bootsy = window.Bootsy || {};

window.Bootsy.imageTemplate = function(locale, options) {
  var size = (options && options.size) ? ' btn-' + options.size : '';

  return  '<li>' +
    '<a class="btn btn-secondary ' + size + '" data-wysihtml5-command="customCommand" title="' + locale.image.insert + '" tabindex="-1">' +
      '<i class="fa fa-picture-o"></i>' +
    '</a>' +
  '</li>';
};
