require 'hipchat'

module ExceptionsToHipchat
  class Notifier
    def initialize(app, options = {})
      @app = app
      @client HipChat::Client.new(options[:api_token] || raise "HipChat API token is required")
      @room = options[:room] || raise "HipChat room is required"
      @color = options[:color] || :red
      @notify = options[:notify]
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception
      @client[@room].send("foo", exception.class, :color => @color, :notify => @notify)
      raise exception
    end
  end
end