/* global Bootsy */

window.Bootsy = window.Bootsy || {};

Bootsy.Area = function($el) {
  this.$el = $el;
  this.editor = $el[0].editor;
  this.unsavedChanges = false;
  this.locale = $el.data('bootsy-locale') || $('html').attr('lang');
  if (!Bootsy.locale.hasOwnProperty(this.locale)) this.locale = 'en';

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
    lists: $el.data('bootsy-lists')
  };
};

// Alert for unsaved changes
Bootsy.Area.prototype.unsavedChangesAlert = function () {
  if (this.unsavedChanges) {
    return Bootsy.locale[this.locale].bootsy.alertUnsaved;
  }
};

// Clear everything
Bootsy.Area.prototype.clear = function () {
  this.$el.editor.loadHTML();
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
      var buttonHTML = '<button type="button" class="insert-image" title="Insert image" data-action="x-insert-image">Insert image</button>';
      var toolbar = $('#' + this.$el.attr('toolbar'));
      toolbar.find(".button_group.block_tools").append(buttonHTML);

      this.modal = new Bootsy.Modal(this);
    }

    this.$el.on('trix-change', function(event) {
      self.unsavedChanges = true;
    }.bind(this));

    this.$el.on('trix-file-accept', function(event) {
      event.preventDefault();
    });

    this.$el.on('trix-action-invoke', function($event) {
      if ($event.originalEvent.actionName === "x-insert-image") {
        this.modal.show();
      }
    }.bind(this));

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
  this.editor.insertHTML(image);
};
