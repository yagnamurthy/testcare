$(document).ready(function() {
  $('.trash').on('click', function(evt) {
    evt.preventDefault();

    var conversation = $(this).parent('.conversation');
    var conversation_id = conversation.data('conversation-id');

    $.ajax({
      method: 'DELETE',
      url: '/messages/' + conversation_id,
      success: function(response) {
        window.location.reload();
      }
    });
  });

  $('.conversation').on('click', function(evt) {
    evt.preventDefault();

    var conversation = $(this);
    conversation.removeClass('new');
    var conversation_id = conversation.data('conversation-id');

    $.ajax({
      method: 'POST',
      url: '/messages/' + conversation_id + '/read',
      success: function(response) {

      }
    });

    $('.thread-messages').attr('style', 'display:none;');
    $('#conversation-messages-' + conversation_id).removeAttr('style');

  });
});
