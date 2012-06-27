function bootsyProgressBar(element){
  element.find('div.index').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
}

function bootsyRefreshIndex(element){
  element.find('a.refresh_btn').show().click();
}

$(document).ready(function(){
  element = $('#bootsy_images');
  element.find('a.refresh_btn').click(function(e){
    $(this).hide();
    bootsyProgressBar(element);
  });

  element.find('a.destroy_btn').click(function(e){
    bootsyProgressBar(element);
  });

  element.modal({show: false});
  element.on('shown', function(){
    bootsyRefreshIndex(element);
  });
});