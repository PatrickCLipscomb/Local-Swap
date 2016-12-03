//= require cable
//= require_self
//= require_tree .

// sends the WebSocket upgrade request, the server will produce a new connection object.

this.App = {};

App.cable = ActionCable.createConsumer("/cable");
