/* global Bootsy */

window.Bootsy = window.Bootsy || {};

Bootsy.Area = function($el) {
  var self = this;

  this.$el = $el;
  this.unsavedChanges = false;
  this.locale = $el.data('bootsy-locale') || $('html').attr('lang');
  if (!Bootsy.locales[this.locale]) {
    this.locale = 'en';
  }

  this.options = {
    locale: this.locale,
    alertUnsavedChanges: $el.data('bootsy-alert-unsaved'),
    uploader: $el.data('bootsy-uploader'),
    toolbar: {
      'color': $el.data('bootsy-color'),
      'emphasis': $el.data('bootsy-emphasis'),
      'font-styles': $el.data('bootsy-font-styles'),
      'html': $el.data('bootsy-html'),
      'image': $el.data('bootsy-image'),
      'link': $el.data('bootsy-link'),
      'lists': $el.data('bootsy-lists')
    },
    events: {
      load: function() {
        self.editor = this;
        self.onEditorLoad();
      },
      change: function() {
        self.unsavedChanges = true;
      }
    }
  };
};

// Alert for unsaved changes
Bootsy.Area.prototype.unsavedChangesAlert = function () {
  if (this.unsavedChanges) {
    return Bootsy.locales[this.locale].alertUnsaved;
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

Bootsy.Area.prototype.onEditorLoad = function() {};

Bootsy.Area.prototype.setupModal = function() {
  this.modal = new Bootsy.Modal(
    this.editor.toolbar.commandMapping['insertImage:null'].dialog.container, this
  );
};

// Init components
Bootsy.Area.prototype.init = function() {
  if (!this.$el.data('bootsy-initialized')) {
    if ((this.options.toolbar.image === true) && (this.options.uploader === true)) {
      this.options.customTemplates = {
        image: Bootsy.imageTemplate
      };

      this.onEditorLoad = this.setupModal;
    }

    this.$el.wysihtml5($.extend(true, Bootsy.options, this.options));

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
