$(document).ready(function() {
  function resize(noteContent) {
    if (noteContent.outerHeight() < noteContent.prop('scrollHeight')) {
      noteContent.css('height', 'auto');
      noteContent.css('height', noteContent.prop('scrollHeight') + 'px');
    }

    var contentWidth = $('.content').width();
    var noteWidth = noteContent.width();
    var margin = (noteWidth - contentWidth) / 2;
    noteContent.css('margin-left', -margin + 'px');
  }

  var noteContent = $('#note_content');
  resize(noteContent);
  $('#note_content').on('click input', function() {
    resize($(this));
  });
});
