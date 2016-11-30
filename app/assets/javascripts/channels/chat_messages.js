$(document).ready(function() {
  App.chat_messages = App.cable.subscriptions.create('ChatMessagesChannel', {
    received: function(data) {
      $("#chat_messages").removeClass('hidden')
      $('#chat_message_body').val('')
      if ($('.chatty').length > 9) {
        $('.chatty').first().remove()
      }
      return $('#chat_messages').append(this.renderMessage(data));
    },
    renderMessage: function(data) {
      return "<p class='chatty'> <b>" + data.user + ": </b>" + data.chat_message + "<span class='pull-right text-muted'>Posted recently</span></p>";
      this.messages_to_bottom()
    },
    messages_to_bottom: function() {
      $('#chat_messages').scrollTop($('#chat_messages').prop("scrollHeight"))
    }
  });
})
