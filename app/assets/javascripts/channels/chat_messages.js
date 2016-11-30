$(document).ready(function() {
  App.chat_messages = App.cable.subscriptions.create('ChatMessagesChannel', {
    received: function(data) {
      $("#chat_message").removeClass('hidden')
      $('#chat_message_body').val('')
      return $('#chat_messages').append(this.renderMessage(data));
    },
    renderMessage: function(data) {
      return "<p> <b>" + data.user + ": </b>" + data.chat_message + "</p>";
    }
  });
})
