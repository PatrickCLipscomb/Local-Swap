$(document).ready(function() {
  App.chat_messages = App.cable.subscriptions.create('ChatMessagesChannel', {
    received: function(data) {
      var chat_room_title_id = data.title
      $("#" + chat_room_title_id).removeClass('hidden')
      $('#chat_message_body').val('')
      if ($('.chatty').length > 9) {
        $('.chatty').first().remove()
      }
      return $('#' + chat_room_title_id).append(this.renderMessage(data));
    },
    renderMessage: function(data) {
      return "<p class='chatty'> <b>" + data.user + ": </b>" + data.chat_message + "<span class='pull-right text-muted'>Posted recently</span></p>";
      this.messages_to_bottom(data)
    },
    messages_to_bottom: function(data) {
      var chat_room_title_id = data.title
      $('#' + chat_room_title_id).scrollTop($('#' + chat_room_title_id).prop("scrollHeight"))
    }
  });
})
