$(function() {
  var editComment = function($comment) {
    cancelEditComment();
    $comment.find('.content').hide();
    $comment.find('.editor').removeClass('hide');
  };

  var cancelEditComment = function() {
    $('.comment .editor').addClass('hide');
    $('.comment .content').show();
  };


  $('.comment a[href="#edit"]').click(function() {
    editComment($(this).parents('.comment'));
  });

  $('.comment a[href="#cancel"]').click(function() {
    cancelEditComment();
  });
});
