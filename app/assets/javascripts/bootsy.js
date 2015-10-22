//= require bootsy/vendor/trix
var buttonHTML, fileInputHTML;

buttonHTML = '<button type="button" class="attach" title="Attach files" data-action="x-attach">Attach Files</button>';

fileInputHTML = '<input type="file" multiple accept="image/*">';

$(Trix.config.toolbar.content).find(".button_group.block_tools").append(buttonHTML);

$(document).on("trix-action-invoke", function($event) {
  var $fileInput, editorElement;

  if ($event.originalEvent.actionName === "x-attach") {
    editorElement = $event.target;
    editorElement.focus();
    $fileInput = $(fileInputHTML);
    $fileInput.on("change", function() {
      var file, i, len, ref, results;
      ref = this.files;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        file = ref[i];
        results.push(editorElement.editor.insertFile(file));
      }
    });
    $fileInput.click();
  }
});

var uploadAttachment;

document.addEventListener('trix-attachment-add', function(event) {
  var attachment;

  attachment = event.attachment;

  if (attachment.file) {
    uploadAttachment(attachment, event.target);
  }
});

uploadAttachment = function(attachment, editor) {
  var file, form, xhr;

  file = attachment.file;

  form = new FormData;
  form.append('image', file);

  xhr = new XMLHttpRequest;
  xhr.open('POST', '/bootsy/images', true);

  xhr.upload.onprogress = function(event) {
    var progress;
    progress = event.loaded / event.total * 100;
    attachment.setUploadProgress(progress);
  };

  xhr.onload = function() {
    var image, input, form;

    if (xhr.status === 201) {
      image = JSON.parse(xhr.response);

      attachment.setAttributes({
        url: image.url,
        href: image.url
      });
    }
  };

  xhr.send(form);
};

