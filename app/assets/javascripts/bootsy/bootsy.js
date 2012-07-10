function bootsyProgressBar(element){
  element.find('div.modal-body').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
}

function bootsyRefreshGallery(element){
  element.find('a.refresh_btn').show().click();
}

function bootsyOpenImageGallery(editor){
  $('#bootsy_image_gallery').modal('show');
}

function bootsyInsertImage(image, editor){
  console.log(image);
  
  $('#bootsy_image_gallery').modal('hide');
  editor.composer.commands.exec("insertImage", image);
}

$(document).ready(function(){
  element = $('#bootsy_image_gallery');
  
  element.parents('form').after(element);

  element.find('a.refresh_btn').live('click', function(e){
    $(this).hide();
    bootsyProgressBar(element);
  });

  element.find('a.destroy_btn').click(function(e){
    bootsyProgressBar(element);
  });

  element.modal({show: false});
  element.on('shown', function(){
    bootsyRefreshGallery(element);
  });

  wysihtml5Editor = $('textarea.bootsy_text_area').wysihtml5({"image": false, "imageUpload": true, imageUploadCallback: bootsyOpenImageGallery}).data("wysihtml5").editor;

  element.on('hide', function() {
    wysihtml5Editor.currentView.element.focus();
  });

  element.on('click.dismiss.modal', '[data-dismiss="modal"]', function(e) {
    e.stopPropagation();
  });

  element.find('a.thumbnail').live('click', function(e){
    bootsyInsertImage({src: $(this).children('img').attr('src').replace("/thumb_", "/full_"), alt: $(this).children('img').attr('alt')}, wysihtml5Editor);
  });
});