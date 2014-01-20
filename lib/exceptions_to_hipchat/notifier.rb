require 'hipchat'

module ExceptionsToHipchat
  class Notifier
    def initialize(app, options = {}, client = nil)
      @app = app
      @client = client || HipChat::Client.new(options[:api_token] || raise("HipChat API token is required"))
      @room = options[:room] || raise("HipChat room is required")
      @color = options[:color] || :red
      @notify = options[:notify]
      @user = (options[:user] || "Notifier")[0...14]
      @ignore = options[:ignore]
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception
      send_to_hipchat(exception) unless @ignore && @ignore.match(exception.to_s)
      raise exception
    end

    def send_to_hipchat(exception)
      begin
        @client[@room].send(@user, message_for(exception), :color => @color, :notify => @notify)
      rescue => hipchat_exception
        $stderr.puts "\nWARN: Unable to send message to HipChat: #{hipchat_exception}\n"
      end
    end

    def message_for(exception)
      "[#{exception.class}] #{exception}"
    end
  end
end
