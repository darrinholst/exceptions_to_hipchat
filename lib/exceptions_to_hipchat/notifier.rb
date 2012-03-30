module ExceptionsToHipchat
  class Notifier
    def initialize(app, options = {})
      @app, @options = app, options
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception
      p exception
      raise exception
    end
  end
end