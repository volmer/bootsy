function bootsyProgressBar(element){
  element.find('div.modal-body').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
}

function bootsyRefreshGallery(element){
  element.find('a.refresh_btn').show().click();
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

  $('textarea.bootsy_text_area').wysihtml5();
});