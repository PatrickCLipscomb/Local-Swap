module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # new connection is instantiated every time a consumer sends the initial WebSocket request forming a connection-consumer pair, this is the place to authorize the incoming request, and find the current user.

    identified_by :current_user

    # The connect callback method will be called when the consumer sends the WebSocket request, triggering a new instance of Connection to be born. 
    def connect
      self.current_user = find_verified_user
    end

    protected
      def find_verified_user
        if verified_user = env['warden'].user
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
