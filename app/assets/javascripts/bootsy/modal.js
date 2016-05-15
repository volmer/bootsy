/* Bootsy modal */

window.Bootsy = window.Bootsy || {};

Bootsy.Modal = function(area) {
  var self = this;

  this.$el = area.$el.siblings('.bootsy-modal');
  this.area = area;

  // In order to avoid form nesting
  this.$el.parents('form').after(this.$el);

  this.$el.on('click', '.bootsy-image .insert', function(event) {
    var img, imageObject;
    var imagePrefix = '/' + $(this).attr('data-image-size') + '_';

    event.preventDefault();

    if ($(this).data('image-size') === 'original') {
      imagePrefix = '/';
    }

    img = $(this).parents('.bootsy-image').find('img');

    imageObject = {
      src: img.attr('src').replace('/thumb_', imagePrefix),
      alt: img.attr('alt').replace('Thumb_', '')
    };

    imageObject.align = $(this).data('position');

    self.$el.modal('hide');

    insert = self.area.insertImage.bind(self.area);
    insert(imageObject);
  });

  this.$el.on('ajax:before', '.destroy-btn', this.showGalleryLoadingAnimation.bind(this));

  this.$el.on('ajax:success', '.destroy-btn', function(_e, data) {
    this.deleteImage(data.id);
  }.bind(this));

  this.$el.on('click', 'a[href="#refresh-gallery"]', this.requestImageGallery.bind(this));

  this.$el.on('submit', '.bootsy-upload-form', function(event, xhr, settings) {
    var fileSelect = event.target.querySelector('input[type="file"]');
    var formData = new FormData();
    var file = fileSelect.files[0];
    var fileURLInputName = 'image[remote_image_file_url]';
    var fileURLInput = event.target.querySelector(
      'input[name="' + fileURLInputName + '"]');
    var fileURL;

    event.preventDefault();

    formData.append('authenticity_token',
      event.target.querySelector('input[name="authenticity_token"]').value);

    if (file) {
      formData.append('image[image_file]', file, file.name);
    }

    if (fileURLInput) {
      fileURL = fileURLInput.value;
    } else {
      fileURL = '';
    }

    formData.append(fileURLInputName, fileURL);

    var xhr = new XMLHttpRequest();
    xhr.open('POST', event.target.action, true);
    xhr.onload = function () {
      var data = JSON.parse(xhr.response);
      if (xhr.status === 200) {
        this.area.setImageGalleryId(data.gallery_id);
        this.addImage(data.image);
        this.setUploadForm(data.form);
      } else {
        this.imageUploadFailed(xhr, data);
      }
    }.bind(this);
    xhr.send(formData);
  }.bind(this));

  this.$el.modal({ show: false });

  this.$el.on('shown.bs.modal', function() {
    if (this.$el.data('gallery-loaded') !== true) {
      this.requestImageGallery();
    }
  }.bind(this));

  this.hideRefreshButton();
  this.hideEmptyAlert();
};

// Show modal
Bootsy.Modal.prototype.show = function() {
  this.$el.modal('show');
};

// Gallery loading
Bootsy.Modal.prototype.showGalleryLoadingAnimation = function() {
  this.$el.find('.bootsy-gallery-loader').fadeIn(200);
};

Bootsy.Modal.prototype.hideGalleryLoadingAnimation = function() {
  this.$el.find('.bootsy-gallery-loader').fadeOut(200);
};

// Upload loading animation
Bootsy.Modal.prototype.showUploadLoadingAnimation = function() {
  this.$el.find('.bootsy-upload-loader').fadeIn(200);
};

Bootsy.Modal.prototype.hideUploadLoadingAnimation = function() {
  this.$el.find('.bootsy-upload-loader').fadeOut(200);
};

// Alert for empty gallery
Bootsy.Modal.prototype.showEmptyAlert = function() {
  this.$el.find('.bootsy-empty-alert').fadeIn(200);
};

Bootsy.Modal.prototype.hideEmptyAlert = function() {
  this.$el.find('.bootsy-empty-alert').fadeOut(200);
};

// Manual refresh button
Bootsy.Modal.prototype.showRefreshButton = function() {
  this.$el.find('.refresh-btn').fadeIn(200);
};

Bootsy.Modal.prototype.hideRefreshButton = function() {
  this.$el.find('.refresh-btn').fadeOut(200);
};

// Set upload form
Bootsy.Modal.prototype.setUploadForm = function(html) {
  var uploadInput;

  this.$el.find('.modal-footer').html(html);
  this.hideUploadLoadingAnimation();
  this.$el.find('.bootsy-upload-form input[type="file"]').bootstrapFileInput();

  uploadInput = this.$el.find('.bootsy-upload-form input[type="file"]');

  uploadInput.change(function() {
    this.showUploadLoadingAnimation();
    uploadInput.closest('form').submit();
  }.bind(this));
};

// The image upload failed
Bootsy.Modal.prototype.imageUploadFailed = function(xhr, invalidErrors) {
  if (Number(xhr.status) === 422 && invalidErrors.image_file) {
    this.hideUploadLoadingAnimation();

    if (this.validation) this.validation.remove();

    this.validation = $("<p class='text-danger'>");
    this.validation.text(invalidErrors.image_file[0]);
    this.$el.find('.bootsy-upload-form').append(this.validation);
  } else {
    this.hideGalleryLoadingAnimation();
    alert($.fn.wysihtml5.locale[this.area.locale].bootsy.error);
  }

  this.showRefreshButton();
};

// Add image to gallery
Bootsy.Modal.prototype.addImage = function(html) {
  this.hideEmptyAlert();

  $(html).hide().appendTo(this.$el.find('.bootsy-gallery')).fadeIn(200);
};

// Set image gallery
Bootsy.Modal.prototype.requestImageGallery = function() {
  this.hideRefreshButton();
  this.showGalleryLoadingAnimation();

  $.ajax({
    url: '/bootsy/images',
    type: 'GET',
    cache: false,
    data: {
      image_gallery_id: this.area.$el.data('gallery-id')
    },
    dataType: 'json',
    success: function(data) {
      this.hideRefreshButton();
      this.hideGalleryLoadingAnimation();
      this.$el.find('.bootsy-gallery .bootsy-image').remove();

      $.each(data.images, function(index, value) {
        this.addImage(value);
      }.bind(this));

      if (data.images.length === 0) this.showEmptyAlert();

      this.setUploadForm(data.form);

      this.$el.data('gallery-loaded', true);
    }.bind(this),
    error: this.imageUploadFailed.bind(this)
  });
};

// Delete image
Bootsy.Modal.prototype.deleteImage = function(id) {
  var image = this.$el.find('.bootsy-image[data-id="' + id + '"]');

  this.hideGalleryLoadingAnimation();

  image.hide(200, function() {
    image.remove();

    if (this.$el.find('.bootsy-image').length === 0 ) this.showEmptyAlert();
  }.bind(this));
};
