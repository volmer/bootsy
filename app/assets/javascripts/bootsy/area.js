/* global Bootsy */

window.Bootsy = window.Bootsy || {};

Bootsy.Area = function($el) {
  var self = this;

  this.$el = $el;
  this.unsavedChanges = false;
  this.locale = $el.data('bootsy-locale') || $('html').attr('lang');
  if (!$.fn.wysihtml5.locale.hasOwnProperty(this.locale)) this.locale = 'en';

  this.options = {
    locale: this.locale,
    alertUnsavedChanges: $el.data('bootsy-alert-unsaved'),
    uploader: $el.data('bootsy-uploader'),
    color: $el.data('bootsy-color'),
    emphasis: $el.data('bootsy-emphasis'),
    'font-styles': $el.data('bootsy-font-styles'),
    html: $el.data('bootsy-html'),
    image: $el.data('bootsy-image'),
    link: $el.data('bootsy-link'),
    lists: $el.data('bootsy-lists'),
    events: {
      change: function() {
        self.unsavedChanges = true;
      }
    }
  };
};

// Alert for unsaved changes
Bootsy.Area.prototype.unsavedChangesAlert = function () {
  if (this.unsavedChanges) {
    return $.fn.wysihtml5.locale[this.locale].bootsy.alertUnsaved;
  }
};

// Clear everything
Bootsy.Area.prototype.clear = function () {
  this.editor.clear();
  this.setImageGalleryId('');
  this.modal.$el.data('gallery-loaded', false);
};

Bootsy.Area.prototype.setImageGalleryId = function(id) {
  this.$el.data('gallery-id', id);
  this.$el.siblings('.bootsy_image_gallery_id').val(id);
};

// Init components
Bootsy.Area.prototype.init = function() {
  if (!this.$el.data('bootsy-initialized')) {
    if ((this.options.image === true) && (this.options.uploader === true)) {
      this.modal = new Bootsy.Modal(this);
      this.options.image = false;
      this.options.customCommand = true;
      this.options.customCommandCallback = this.modal.show.bind(this.modal);
      this.options.customTemplates = { customCommand: Bootsy.imageTemplate };
    }

    this.editor = this.$el.wysihtml5($.extend(true, {}, Bootsy.options, this.options)).data('wysihtml5').editor;

    // Mechanism for unsaved changes alert
    if (this.options.alertUnsavedChanges !== false) {
      window.onbeforeunload = this.unsavedChangesAlert.bind(this);
    }

    this.$el.closest('form').submit(function() {
      this.unsavedChanges = false;

      return true;
    }.bind(this));

    this.$el.data('bootsy-initialized', true);
  }
};

// Insert image in the text
Bootsy.Area.prototype.insertImage = function(image) {
  this.editor.currentView.element.focus();

  if (this.caretBookmark) {
    this.editor.composer.selection.setBookmark(this.caretBookmark);
    this.caretBookmark = null;
  }

  this.editor.composer.commands.exec('insertImage', image);
};
