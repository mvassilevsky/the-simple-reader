$(document).ready(function() {
  var markRead = function(unreadPost) {
    unreadPost.removeClass('unread');

    var post_id = unreadPost.data('id');
    $.post('/posts/' + post_id + '/mark_read', {
      authenticity_token: $('[name="csrf-token"]')[0].content
    })
  };

  $('.post.unread').on('click', function() {
    markRead($(this))
  });

  $('.post.unread').each(function() {
    var unreadPost = $(this);
    $(window).on('scroll', function() {
      if ($(window).scrollTop() > unreadPost.offset().top) {
        markRead(unreadPost);
      }
    });
  });
});
