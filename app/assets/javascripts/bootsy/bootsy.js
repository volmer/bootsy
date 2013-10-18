window.Bootsy = window.Bootsy || {};

Bootsy.Area = function($el) {
  this.$el = $el;
  this.modal = $el.siblings('.bootsy-modal');
  this.locale = $el.data('bootsy-locale') || $('html').attr('lang') || 'en';
  this.unsavedChanges = false;

  this.options = {
    locale: this.locale,
    alertUnsavedChanges: $el.data('bootsy-alert-unsaved'),
    image: $el.data('bootsy-image'),
    uploader: $el.data('bootsy-uploader'),
  };

  if ($el.data('bootsy-font-styles') === false) this.options['font-styles'] = false;
  if ($el.data('bootsy-emphasis') === false) this.options.emphasis = false;
  if ($el.data('bootsy-lists') === false) this.options.lists = false;
  if ($el.data('bootsy-html') === true) this.options.html = true;
  if ($el.data('bootsy-link') === false) this.options.link = false;
  if ($el.data('bootsy-color') === false) this.options.color = false;

  // Delegate find to the modal
  this.find = this.modal.find.bind(this.modal);
};


// Gallery loading
Bootsy.Area.prototype.showGalleryLoadingAnimation = function() {
  this.find('.bootsy-gallery-loader').fadeIn(200);
};

Bootsy.Area.prototype.hideGalleryLoadingAnimation = function() {
  this.find('.bootsy-gallery-loader').fadeOut(200);
};


// Upload loading animation
Bootsy.Area.prototype.showUploadLoadingAnimation = function() {
  this.find('.bootsy-upload-loader').fadeIn(200);
};

Bootsy.Area.prototype.hideUploadLoadingAnimation = function() {
  this.find('.bootsy-upload-loader').fadeOut(200);
};

// Alert for empty gallery
Bootsy.Area.prototype.showEmptyAlert = function() {
  this.find('.bootsy-empty-alert').fadeIn(200);
};

Bootsy.Area.prototype.hideEmptyAlert = function() {
  this.find('.bootsy-empty-alert').fadeOut(200);
};

// Manual refresh button
Bootsy.Area.prototype.showRefreshButton = function() {
  this.find('.refresh-btn').fadeIn(200);
};

Bootsy.Area.prototype.hideRefreshButton = function() {
  this.find('.refresh-btn').fadeOut(200);
};


// Set upload form
Bootsy.Area.prototype.setUploadForm = function(html) {
  var form;

  this.find('.modal-footer').html(html);

  this.hideUploadLoadingAnimation();

  this.find('.bootsy-upload-form input[type="file"]').bootstrapFileInput();

  this.uploadInput = this.find('.bootsy-upload-form input[type="file"]');

  this.uploadInput.change(function() {
    this.showUploadLoadingAnimation();

    this.uploadInput.closest('form').submit();
  }.bind(this));
};


// Set image gallery
Bootsy.Area.prototype.setImageGallery = function() {
  this.showGalleryLoadingAnimation();

  $.ajax({
    url: '/bootsy/images',
    type: 'GET',
    cache: false,
    data: {
      image_gallery_id: this.modal.data('gallery-id')
    },
    dataType: 'json',
    success: function(data) {
      this.hideGalleryLoadingAnimation();

      $.each(data.images, function(index, value) {
        this.addImage(value);
      }.bind(this));

      if (data.images.length == 0) {
        this.showEmptyAlert();
      }

      this.setUploadForm(data.form);

      this.modal.data('gallery-loaded', true);
    }.bind(this),
    error: function(e) {
      alert(Bootsy.translations[this.locale].error);

      this.showRefreshButton();
    }.bind(this)
  });
};

// Delete image
Bootsy.Area.prototype.deleteImage = function (id) {
  var image = this.find('.bootsy-image[data-id="' + id + '"]');

  this.hideGalleryLoadingAnimation();

  image.hide(200, function() {
    image.remove();

    // Put message back if 0 images
    if (this.find('.bootsy-image').length == 0 ) {
      this.showEmptyAlert();
    }
  }.bind(this));
};


// Add image to gallery
Bootsy.Area.prototype.addImage = function(html) {
  $(html).hide().appendTo(this.find('.bootsy-gallery')).fadeIn(200);

  this.hideEmptyAlert();
};

// Insert image in the text
Bootsy.Area.prototype.insertImage = function(image) {
  this.modal.modal('hide');

  this.editor.currentView.element.focus();

  if (this.caretBookmark) {
    this.editor.composer.selection.setBookmark(this.caretBookmark);
    this.caretBookmark = null;
  }

  this.editor.composer.commands.exec('insertImage', image);
};

// Open Bootsy modal
Bootsy.Area.prototype.openImagesModal = function(editor) {
  editor.currentView.element.focus(false);

  this.caretBookmark = editor.composer.selection.getBookmark();

  this.modal.modal('show');
};

// Alert for unsaved changes
Bootsy.Area.prototype.unsavedChangesAlert = function () {
  if (this.unsavedChanges) {
    return Bootsy.translations[this.locale].alertUnsaved;
  }
};

// Clear everything
Bootsy.Area.prototype.clear = function () {
  this.editor.clear();
  this.setImageGalleryId('');
  this.modal.data('gallery-loaded', false);
};

// Set the image gallery id
Bootsy.Area.prototype.setImageGalleryId = function(id) {
  this.modal.data('gallery-id', id);

  this.$el.siblings('.bootsy_image_gallery_id').val(id);
};


// Init components
Bootsy.Area.prototype.init = function() {
  var insert = this.insertImage.bind(this);

  if ((this.options.image === true) && (this.options.uploader === true)) {
    this.modal.on('click', '.bootsy-image .insert', function(e) {
      var img, imageObject;
      var imagePrefix = '/' + $(this).attr('data-image-size') + '_';

      if ($(this).data('image-size') === 'original') {
        imagePrefix = '/';
      }

      img = $(this).parents('.bootsy-image').find('img');

      imageObject = {
        src: img.attr('src').replace('/thumb_', imagePrefix),
        alt: img.attr('alt').replace('Thumb_', '')
      };

      imageObject.align = $(this).data('position');

      insert(imageObject);
    });

    // Let's use the uploader, not the static image modal
    this.options.image = false;
    this.options.customCommand = true;
    this.options.customCommandCallback = this.openImagesModal.bind(this);
    this.options.customTemplates = {
      customCommand: function(locale, options) {
        var size = (options && options.size) ? ' btn-'+options.size : '';

        return  '<li>' +
                  '<a class="btn btn-default ' + size + '" data-wysihtml5-command="customCommand" title="' + locale.image.insert + '" tabindex="-1">' +
                    '<i class="icon-picture"></i>' +
                  '</a>' +
                '</li>';
      }
    };

    // In order to avoid form nesting
    this.modal.parents('form').after(this.modal);

    this.modal.on('click', 'a[href="#refresh-gallery"]', this.setImageGallery.bind(this));

    this.modal.on('ajax:before', '.destroy-btn', this.showGalleryLoadingAnimation.bind(this));

    this.modal.on('ajax:success', '.destroy-btn', function(evt, data) {
      this.deleteImage(data.id);
    }.bind(this));

    this.modal.on('ajax:success', '.bootsy-upload-form', function(evt, data) {
      this.setImageGalleryId(data.gallery_id);
      this.addImage(data.image);
      this.setUploadForm(data.form);
    }.bind(this));
  }

  this.editor = this.$el.wysihtml5($.extend(Bootsy.options, this.options)).data('wysihtml5').editor;

  // Mechanism for unsaved changes alert
  if (this.options.alertUnsavedChanges !== false) {
    window.onbeforeunload = this.unsavedChangesAlert.bind(this);
  }

  this.$el.closest('form').submit(function(e) {
    this.unsavedChanges = false;

    return true;
  }.bind(this));

  this.editor.on('change', function() {
    this.unsavedChanges = true;
  }.bind(this));

  this.modal.modal({ show: false });

  this.modal.on('shown.bs.modal', function() {
    if (this.modal.data('gallery-loaded') !== true) {
      this.setImageGallery();
    }
  }.bind(this));

  this.modal.on('hide.bs.modal', this.editor.currentView.element.focus);

  this.hideRefreshButton();
};
